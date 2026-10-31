use std::{
    collections::VecDeque,
    pin::Pin,
    sync::Arc,
    time::{SystemTime, UNIX_EPOCH},
};
use tokio::sync::{watch, Mutex};
use tokio_stream::{wrappers::WatchStream, Stream, StreamExt};
use tonic::{Request, Response, Status};
pub mod pb {
    tonic::include_proto!("aerocontrol.v1");
}
use pb::{ground_control_server::GroundControl, *};

pub fn now_ms() -> i64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_millis() as i64
}
const HOME: (f64, f64) = (51.5074, -0.1278);
const MAX_EVENTS: usize = 500;

pub struct Simulator {
    pub telemetry: Telemetry,
    events: VecDeque<Event>,
    next_event: u64,
    gps_fault: bool,
    battery_fault: bool,
}
impl Default for Simulator {
    fn default() -> Self {
        let mut s = Self {
            telemetry: Telemetry {
                timestamp_ms: now_ms(),
                latitude: HOME.0,
                longitude: HOME.1,
                battery_pct: 100.,
                voltage: 16.8,
                satellites: 14,
                gps_healthy: true,
                battery_healthy: true,
                temperature_c: 32.,
                ..Default::default()
            },
            events: VecDeque::new(),
            next_event: 1,
            gps_fault: false,
            battery_fault: false,
        };
        s.event(Severity::Info, "Simulator online · AERO-01 ready");
        s
    }
}
impl Simulator {
    fn event(&mut self, severity: Severity, message: impl Into<String>) {
        let message = message.into();
        tracing::info!(event_id = self.next_event, ?severity, %message, "vehicle event");
        self.events.push_back(Event {
            id: self.next_event,
            timestamp_ms: now_ms(),
            severity: severity as i32,
            message,
        });
        self.next_event += 1;
        if self.events.len() > MAX_EVENTS {
            self.events.pop_front();
        }
    }
    fn mode(&self) -> FlightMode {
        FlightMode::try_from(self.telemetry.mode).unwrap_or(FlightMode::Disarmed)
    }
    fn set_mode(&mut self, mode: FlightMode) {
        self.telemetry.mode = mode as i32;
    }
    pub fn execute(&mut self, command: Command) -> CommandReply {
        let mode = self.mode();
        let result: Result<&str, &str> = match command {
            Command::Arm
                if mode == FlightMode::Disarmed
                    && self.telemetry.gps_healthy
                    && self.telemetry.battery_healthy
                    && self.telemetry.battery_pct > 20. =>
            {
                self.set_mode(FlightMode::Armed);
                Ok("Vehicle armed")
            }
            Command::Disarm if self.telemetry.altitude_m <= 0.1 => {
                self.set_mode(FlightMode::Disarmed);
                Ok("Vehicle disarmed")
            }
            Command::StartMission
                if matches!(mode, FlightMode::Armed | FlightMode::Hold)
                    && self.telemetry.gps_healthy
                    && self.telemetry.battery_healthy
                    && self.telemetry.battery_pct > 20. =>
            {
                if self.telemetry.mission_progress >= 1. {
                    self.telemetry.mission_progress = 0.;
                }
                self.set_mode(FlightMode::Mission);
                Ok("Mission started")
            }
            Command::HoldPosition
                if matches!(mode, FlightMode::Mission | FlightMode::Returning) =>
            {
                self.set_mode(FlightMode::Hold);
                Ok("Holding position")
            }
            Command::ReturnHome if self.telemetry.altitude_m > 0. && self.telemetry.gps_healthy => {
                self.set_mode(FlightMode::Returning);
                Ok("Returning to home")
            }
            Command::Land if self.telemetry.altitude_m > 0. => {
                self.set_mode(FlightMode::Landing);
                Ok("Landing initiated")
            }
            Command::InjectGpsFault => {
                self.gps_fault = true;
                Ok("GPS fault injected")
            }
            Command::InjectBatteryFault => {
                self.battery_fault = true;
                Ok("Battery fault injected")
            }
            Command::ClearFaults => {
                self.gps_fault = false;
                self.battery_fault = false;
                Ok("Injected faults cleared")
            }
            Command::Reset if mode == FlightMode::Disarmed => {
                let sequence = self.telemetry.sequence;
                self.telemetry = Simulator::default().telemetry;
                self.telemetry.sequence = sequence;
                self.gps_fault = false;
                self.battery_fault = false;
                Ok("Simulator reset")
            }
            _ => Err("Command rejected: check flight mode, GPS, battery and altitude"),
        };
        self.update_health();
        let (accepted, message) = match result {
            Ok(m) => (true, m),
            Err(m) => (false, m),
        };
        self.event(
            if accepted {
                Severity::Info
            } else {
                Severity::Warning
            },
            message,
        );
        CommandReply {
            accepted,
            message: message.into(),
            telemetry: Some(self.telemetry.clone()),
        }
    }
    fn update_health(&mut self) {
        let gps = !self.gps_fault;
        let battery = !self.battery_fault && self.telemetry.battery_pct > 20.;
        if gps != self.telemetry.gps_healthy {
            self.event(
                if gps {
                    Severity::Info
                } else {
                    Severity::Critical
                },
                if gps {
                    "GPS signal restored"
                } else {
                    "GPS signal lost"
                },
            );
        }
        if battery != self.telemetry.battery_healthy {
            self.event(
                if battery {
                    Severity::Info
                } else {
                    Severity::Critical
                },
                if battery {
                    "Battery health restored"
                } else {
                    "Battery below safe threshold or fault detected"
                },
            );
        }
        self.telemetry.gps_healthy = gps;
        self.telemetry.battery_healthy = battery;
        self.telemetry.satellites = if gps { 14 } else { 0 };
        self.telemetry.alerts.clear();
        if !gps {
            self.telemetry
                .alerts
                .push("GPS unavailable · navigation degraded".into());
        }
        if !battery {
            self.telemetry
                .alerts
                .push("Battery critical · landing required".into());
        }
        if !battery && self.telemetry.altitude_m > 0. && self.mode() != FlightMode::Landing {
            self.set_mode(FlightMode::Landing);
            self.event(Severity::Critical, "Failsafe: automatic landing");
        } else if !gps && matches!(self.mode(), FlightMode::Mission | FlightMode::Returning) {
            self.set_mode(FlightMode::Hold);
            self.event(
                Severity::Warning,
                "Failsafe: position hold; operator action required",
            );
        }
    }
    pub fn tick(&mut self, dt: f64) {
        let dt = dt.clamp(0., 1.);
        self.telemetry.sequence += 1;
        self.telemetry.timestamp_ms = now_ms();
        let phase = self.telemetry.sequence as f64 * 0.05;
        self.telemetry.cpu_pct = 28. + phase.sin() * 7.;
        self.telemetry.temperature_c = 35. + phase.cos() * 2.;
        self.telemetry.speed_mps = 0.;
        match self.mode() {
            FlightMode::Mission => {
                self.telemetry.altitude_m = (self.telemetry.altitude_m + 8. * dt).min(80.);
                self.telemetry.speed_mps = 12.;
                self.telemetry.mission_progress =
                    (self.telemetry.mission_progress + dt / 120.).min(1.);
                let angle = self.telemetry.mission_progress * std::f64::consts::TAU;
                self.telemetry.latitude = HOME.0 + 0.003 * angle.sin();
                self.telemetry.longitude = HOME.1 + 0.004 * (1. - angle.cos());
                self.telemetry.heading_deg = angle.to_degrees() % 360.;
                if self.telemetry.mission_progress >= 1. {
                    self.set_mode(FlightMode::Returning);
                    self.event(Severity::Info, "Route complete · returning home");
                }
            }
            FlightMode::Returning => {
                self.telemetry.speed_mps = 10.;
                let k = (dt * 0.25).min(1.);
                self.telemetry.latitude += (HOME.0 - self.telemetry.latitude) * k;
                self.telemetry.longitude += (HOME.1 - self.telemetry.longitude) * k;
                if (self.telemetry.latitude - HOME.0).abs()
                    + (self.telemetry.longitude - HOME.1).abs()
                    < 0.00002
                {
                    self.telemetry.latitude = HOME.0;
                    self.telemetry.longitude = HOME.1;
                    self.set_mode(FlightMode::Landing);
                    self.event(Severity::Info, "Home reached · descending");
                }
            }
            FlightMode::Landing => {
                self.telemetry.altitude_m = (self.telemetry.altitude_m - 5. * dt).max(0.);
                if self.telemetry.altitude_m == 0. {
                    self.set_mode(FlightMode::Disarmed);
                    self.event(Severity::Info, "Touchdown · vehicle disarmed");
                }
            }
            _ => {}
        }
        if self.mode() != FlightMode::Disarmed {
            self.telemetry.battery_pct = (self.telemetry.battery_pct - dt * 0.06).max(0.);
        }
        self.telemetry.voltage = 12. + 4.8 * self.telemetry.battery_pct / 100.;
        self.update_health();
    }
}

#[derive(Clone)]
pub struct ControlService {
    state: Arc<Mutex<Simulator>>,
    tx: watch::Sender<Telemetry>,
}
impl Default for ControlService {
    fn default() -> Self {
        Self::new()
    }
}
impl ControlService {
    pub fn new() -> Self {
        let state = Simulator::default();
        let (tx, _) = watch::channel(state.telemetry.clone());
        Self {
            state: Arc::new(Mutex::new(state)),
            tx,
        }
    }
    pub async fn tick(&self, dt: f64) {
        let mut s = self.state.lock().await;
        s.tick(dt);
        self.tx.send_replace(s.telemetry.clone());
    }
    pub fn spawn_simulation(&self) -> tokio::task::JoinHandle<()> {
        let service = self.clone();
        tokio::spawn(async move {
            let mut timer = tokio::time::interval(std::time::Duration::from_millis(200));
            loop {
                timer.tick().await;
                service.tick(0.2).await;
            }
        })
    }
}
#[tonic::async_trait]
impl GroundControl for ControlService {
    async fn get_snapshot(&self, _: Request<Empty>) -> Result<Response<Telemetry>, Status> {
        Ok(Response::new(self.state.lock().await.telemetry.clone()))
    }
    type WatchTelemetryStream = Pin<Box<dyn Stream<Item = Result<Telemetry, Status>> + Send>>;
    async fn watch_telemetry(
        &self,
        _: Request<Empty>,
    ) -> Result<Response<Self::WatchTelemetryStream>, Status> {
        Ok(Response::new(Box::pin(
            WatchStream::new(self.tx.subscribe()).map(Ok),
        )))
    }
    async fn execute_command(
        &self,
        req: Request<CommandRequest>,
    ) -> Result<Response<CommandReply>, Status> {
        let command = Command::try_from(req.into_inner().command)
            .map_err(|_| Status::invalid_argument("Unknown command"))?;
        let mut s = self.state.lock().await;
        let result = s.execute(command);
        self.tx.send_replace(s.telemetry.clone());
        Ok(Response::new(result))
    }
    async fn get_events(&self, req: Request<EventQuery>) -> Result<Response<EventLog>, Status> {
        let after = req.into_inner().after_id;
        let s = self.state.lock().await;
        Ok(Response::new(EventLog {
            events: s.events.iter().filter(|e| e.id > after).cloned().collect(),
        }))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn rejects_unsafe_transitions() {
        let mut s = Simulator::default();
        assert!(!s.execute(Command::StartMission).accepted);
        assert!(s.execute(Command::Arm).accepted);
        assert!(s.execute(Command::StartMission).accepted);
        s.tick(1.);
        assert!(!s.execute(Command::Disarm).accepted);
    }
    #[test]
    fn faults_trigger_failsafes_and_log_once() {
        let mut s = Simulator::default();
        s.execute(Command::Arm);
        s.execute(Command::StartMission);
        s.tick(1.);
        s.execute(Command::InjectGpsFault);
        assert_eq!(s.mode(), FlightMode::Hold);
        let count = s.events.len();
        s.tick(0.2);
        assert_eq!(s.events.len(), count);
        s.execute(Command::InjectBatteryFault);
        assert_eq!(s.mode(), FlightMode::Landing);
        for _ in 0..10 {
            s.tick(1.);
        }
        assert_eq!(s.mode(), FlightMode::Disarmed);
        s.execute(Command::ClearFaults);
        assert!(s.telemetry.gps_healthy);
    }
    #[test]
    fn log_is_bounded_and_reset_preserves_ids() {
        let mut s = Simulator::default();
        for _ in 0..600 {
            s.execute(Command::ClearFaults);
        }
        assert_eq!(s.events.len(), MAX_EVENTS);
        let id = s.next_event;
        s.execute(Command::Reset);
        assert!(s.next_event > id);
    }
    #[test]
    fn battery_fault_blocks_arming_and_mission_start() {
        let mut s = Simulator::default();
        s.execute(Command::InjectBatteryFault);
        assert!(!s.execute(Command::Arm).accepted);
        s.execute(Command::ClearFaults);
        assert!(s.execute(Command::Arm).accepted);
        s.execute(Command::InjectBatteryFault);
        assert!(!s.execute(Command::StartMission).accepted);
    }
    #[test]
    fn mission_completes_and_lands() {
        let mut s = Simulator::default();
        s.execute(Command::Arm);
        s.execute(Command::StartMission);
        for _ in 0..250 {
            s.tick(1.);
        }
        assert_eq!(s.mode(), FlightMode::Disarmed);
        assert_eq!(s.telemetry.altitude_m, 0.);
        assert!(s.telemetry.mission_progress >= 1.);
    }
}
