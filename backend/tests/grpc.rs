use aerocontrol::{
    pb::{
        ground_control_client::GroundControlClient, ground_control_server::GroundControlServer,
        Command, CommandRequest, Empty, EventQuery, FlightMode,
    },
    ControlService,
};
use tokio_stream::wrappers::TcpListenerStream;
use tonic::transport::Server;

#[tokio::test]
async fn grpc_commands_streaming_events_and_reconnection() {
    let listener = tokio::net::TcpListener::bind("127.0.0.1:0").await.unwrap();
    let addr = listener.local_addr().unwrap();
    let service = ControlService::new();
    let simulation = service.spawn_simulation();
    let server = tokio::spawn(
        Server::builder()
            .add_service(GroundControlServer::new(service))
            .serve_with_incoming(TcpListenerStream::new(listener)),
    );
    let mut client = GroundControlClient::connect(format!("http://{addr}"))
        .await
        .unwrap();
    let mut stream = client.watch_telemetry(Empty {}).await.unwrap().into_inner();
    let initial = stream.message().await.unwrap().unwrap();
    assert_eq!(initial.mode, FlightMode::Disarmed as i32);
    let rejected = client
        .execute_command(CommandRequest {
            command: Command::StartMission as i32,
        })
        .await
        .unwrap()
        .into_inner();
    assert!(!rejected.accepted);
    for command in [Command::Arm, Command::StartMission] {
        assert!(
            client
                .execute_command(CommandRequest {
                    command: command as i32
                })
                .await
                .unwrap()
                .into_inner()
                .accepted
        );
    }
    tokio::time::sleep(std::time::Duration::from_millis(450)).await;
    let telemetry = client.get_snapshot(Empty {}).await.unwrap().into_inner();
    assert!(telemetry.altitude_m > 0.);
    assert!(telemetry.sequence > initial.sequence);
    client
        .execute_command(CommandRequest {
            command: Command::InjectGpsFault as i32,
        })
        .await
        .unwrap();
    let fault = client.get_snapshot(Empty {}).await.unwrap().into_inner();
    assert!(!fault.gps_healthy);
    assert_eq!(fault.mode, FlightMode::Hold as i32);
    let events = client
        .get_events(EventQuery { after_id: 0 })
        .await
        .unwrap()
        .into_inner()
        .events;
    assert!(events.iter().any(|e| e.message.contains("Failsafe")));
    let last = events.last().unwrap().id;
    assert!(client
        .get_events(EventQuery { after_id: last })
        .await
        .unwrap()
        .into_inner()
        .events
        .is_empty());
    let error = client
        .execute_command(CommandRequest { command: 999 })
        .await
        .unwrap_err();
    assert_eq!(error.code(), tonic::Code::InvalidArgument);
    drop(stream);
    drop(client);
    let mut reconnected = GroundControlClient::connect(format!("http://{addr}"))
        .await
        .unwrap();
    assert_eq!(
        reconnected
            .get_snapshot(Empty {})
            .await
            .unwrap()
            .into_inner()
            .mode,
        FlightMode::Hold as i32
    );
    simulation.abort();
    server.abort();
}

#[tokio::test]
async fn browser_grpc_web_unary_request() {
    use tokio::io::{AsyncReadExt, AsyncWriteExt};
    let listener = tokio::net::TcpListener::bind("127.0.0.1:0").await.unwrap();
    let addr = listener.local_addr().unwrap();
    let server = tokio::spawn(
        Server::builder()
            .accept_http1(true)
            .layer(tonic_web::GrpcWebLayer::new())
            .add_service(GroundControlServer::new(ControlService::new()))
            .serve_with_incoming(TcpListenerStream::new(listener)),
    );
    let mut socket = tokio::net::TcpStream::connect(addr).await.unwrap();
    let headers = format!("POST /aerocontrol.v1.GroundControl/GetSnapshot HTTP/1.1\r\nHost: {addr}\r\nContent-Type: application/grpc-web+proto\r\nX-Grpc-Web: 1\r\nOrigin: http://localhost:8080\r\nContent-Length: 5\r\nConnection: close\r\n\r\n");
    socket.write_all(headers.as_bytes()).await.unwrap();
    socket.write_all(&[0, 0, 0, 0, 0]).await.unwrap();
    let mut response = Vec::new();
    tokio::time::timeout(
        std::time::Duration::from_secs(3),
        socket.read_to_end(&mut response),
    )
    .await
    .unwrap()
    .unwrap();
    let text = String::from_utf8_lossy(&response);
    assert!(text.starts_with("HTTP/1.1 200"), "{text}");
    assert!(text.contains("application/grpc-web+proto"), "{text}");
    assert!(
        text.contains("grpc-status:0") || text.contains("grpc-status: 0"),
        "{text}"
    );
    server.abort();
}
