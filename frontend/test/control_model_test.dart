import 'dart:async';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:aerocontrol/generated/aerocontrol.pbgrpc.dart';
import 'package:aerocontrol/services/control_model.dart';

class FlakyService extends GroundControlServiceBase {
  int connections = 0;
  int commands = 0;
  @override
  Stream<Telemetry> watchTelemetry(ServiceCall call, Empty request) async* {
    final attempt = ++connections;
    yield Telemetry(sequence: Int64(attempt), mode: FlightMode.DISARMED);
    if (attempt == 1) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      throw GrpcError.unavailable('Simulated link interruption');
    }
    yield* Stream.periodic(const Duration(milliseconds: 200),
        (_) => Telemetry(sequence: Int64(2), mode: FlightMode.DISARMED));
  }

  @override
  Future<Telemetry> getSnapshot(ServiceCall call, Empty request) async =>
      Telemetry();
  @override
  Future<CommandReply> executeCommand(
      ServiceCall call, CommandRequest request) async {
    commands++;
    return CommandReply(
        accepted: true,
        message: 'Vehicle armed',
        telemetry: Telemetry(mode: FlightMode.ARMED));
  }

  @override
  Future<EventLog> getEvents(ServiceCall call, EventQuery request) async =>
      EventLog();
}

Future<void> until(ControlModel model, bool Function() predicate) async {
  if (predicate()) return;
  final done = Completer<void>();
  void listener() {
    if (predicate() && !done.isCompleted) done.complete();
  }

  model.addListener(listener);
  try {
    await done.future.timeout(const Duration(seconds: 6));
  } finally {
    model.removeListener(listener);
  }
}

void main() {
  test(
      'client reconnects after stream failure and gates commands while offline',
      () async {
    final service = FlakyService();
    final server = Server.create(services: [service]);
    await server.serve(address: '127.0.0.1', port: 0);
    final model = ControlModel(endpoint: 'http://127.0.0.1:${server.port}');
    try {
      await model.command(Command.ARM);
      expect(service.commands, 0);
      model.connect();
      await until(model, () => model.connected);
      await until(model, () => model.status == LinkStatus.reconnecting);
      await model.command(Command.ARM);
      expect(service.commands, 0);
      await until(model, () => model.connected && service.connections >= 2);
      await model.command(Command.ARM);
      expect(service.commands, 1);
      expect(model.notice, 'Vehicle armed');
      expect(model.busy, false);
    } finally {
      model.dispose();
      await server.shutdown();
    }
  });
}
