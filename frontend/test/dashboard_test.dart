import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aerocontrol/main.dart';
import 'package:aerocontrol/services/control_model.dart';
import 'package:aerocontrol/generated/aerocontrol.pb.dart';

void main() {
  testWidgets('offline controls are disabled at desktop and mobile widths',
      (tester) async {
    final model = ControlModel();
    for (final size in [const Size(1440, 1000), const Size(390, 844)]) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(
          MaterialApp(theme: ThemeData.dark(), home: Dashboard(model: model)));
      expect(find.text('Mission overview'), findsOneWidget);
      expect(find.textContaining('Commands are disabled'), findsOneWidget);
      expect(
          tester
              .widget<FilledButton>(
                  find.widgetWithText(FilledButton, 'Start / resume mission'))
              .onPressed,
          isNull);
      expect(tester.takeException(), isNull);
    }
    await tester.pumpWidget(const SizedBox());
    model.dispose();
    await tester.binding.setSurfaceSize(null);
  });
  testWidgets('connected vehicle exposes arm and health status',
      (tester) async {
    final model = ControlModel()
      ..status = LinkStatus.connected
      ..telemetry = Telemetry(
          mode: FlightMode.DISARMED,
          batteryPct: 100,
          gpsHealthy: true,
          batteryHealthy: true,
          satellites: 14);
    await tester.binding.setSurfaceSize(const Size(1440, 1200));
    await tester.pumpWidget(
        MaterialApp(theme: ThemeData.dark(), home: Dashboard(model: model)));
    expect(
        tester
            .widget<FilledButton>(
                find.widgetWithText(FilledButton, 'Arm vehicle'))
            .onPressed,
        isNotNull);
    expect(find.text('14 satellites'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    model.dispose();
    await tester.binding.setSurfaceSize(null);
  });
}
