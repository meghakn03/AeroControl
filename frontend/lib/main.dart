import 'package:flutter/material.dart';
import 'generated/aerocontrol.pb.dart';
import 'services/control_model.dart';
import 'widgets/plots.dart';

void main() => runApp(const AeroControlApp());
const bg = Color(0xFF091118);
const panel = Color(0xFF111D27);
const border = Color(0xFF23323E);
const amber = Color(0xFFF4B860);

class AeroControlApp extends StatelessWidget {
  const AeroControlApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'AeroControl',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          scaffoldBackgroundColor: bg,
          colorScheme: const ColorScheme.dark(primary: mint, surface: panel),
          fontFamily: 'Arial',
          dividerColor: border,
          filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(18))),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: border),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(18)))),
      home: const Dashboard());
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.model});
  final ControlModel? model;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final ControlModel model;
  @override
  void initState() {
    super.initState();
    model = widget.model ?? ControlModel();
    if (widget.model == null) model.connect();
  }

  @override
  void dispose() {
    if (widget.model == null) model.dispose();
    super.dispose();
  }

  Future<void> _confirm(Command command, String title) async {
    final yes = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
                title: Text(title),
                content:
                    const Text('This changes the simulated vehicle state.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel')),
                  FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Confirm'))
                ]));
    if (yes == true) await model.command(command);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: model,
      builder: (context, _) {
        final t = model.telemetry;
        return Scaffold(
            body: SafeArea(child: LayoutBuilder(builder: (context, bounds) {
          final wide = bounds.maxWidth >= 1000;
          return Row(children: [
            if (wide) _sidebar(),
            Expanded(
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(wide ? 32 : 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(),
                          const SizedBox(height: 28),
                          Wrap(spacing: 12, runSpacing: 12, children: [
                            _metric(
                                'ALTITUDE', t?.altitudeM, 'm', Icons.height, 0),
                            _metric('GROUND SPEED', t?.speedMps, 'm/s',
                                Icons.speed, 1),
                            _metric('BATTERY', t?.batteryPct, '%',
                                Icons.battery_5_bar, 0),
                            _metric('HEADING', t?.headingDeg, '°',
                                Icons.explore_outlined, 0),
                          ]),
                          const SizedBox(height: 22),
                          if (!model.connected)
                            Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _banner(
                                    'Telemetry unavailable · ${model.status.name}. Commands are disabled.',
                                    amber)),
                          if (t != null && t.alerts.isNotEmpty)
                            ...t.alerts.map((a) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _banner(a, Colors.redAccent))),
                          if (model.notice != null)
                            Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _banner(model.notice!, mint)),
                          _columns(wide, _flightPanel(), _missionPanel()),
                          const SizedBox(height: 20),
                          _columns(wide, _charts(), _health()),
                          const SizedBox(height: 20),
                          _events(),
                          const SizedBox(height: 20),
                          const Text(
                              'SIMULATION ENVIRONMENT  /  No physical vehicle connected',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: muted,
                                  letterSpacing: 1)),
                        ])))
          ]);
        })));
      });
  Widget _sidebar() => Container(
      width: 190,
      decoration: const BoxDecoration(
          color: Color(0xFF0D1720),
          border: Border(right: BorderSide(color: border))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.flight_takeoff, color: mint, size: 30),
        const SizedBox(height: 16),
        const Text('AERO\nCONTROL',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                letterSpacing: 3,
                height: 1.2)),
        const SizedBox(height: 8),
        const Text('GROUND STATION',
            style: TextStyle(fontSize: 9, color: muted, letterSpacing: 2)),
        const SizedBox(height: 48),
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: mint.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.dashboard_outlined, color: mint, size: 18),
              SizedBox(width: 10),
              Expanded(
                  child: Text('Overview',
                      style: TextStyle(color: mint, fontSize: 13)))
            ])),
        const Spacer(),
        const Text('AERO-01', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Quadrotor · Simulator\nv0.1.0',
            style: TextStyle(color: muted, fontSize: 11, height: 1.8)),
      ]));
  Widget _header() => Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 24,
          runSpacing: 16,
          children: [
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('OPERATIONS / AERO-01',
                      style: TextStyle(
                          color: muted, fontSize: 10, letterSpacing: 2)),
                  SizedBox(height: 8),
                  Text('Mission overview',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700))
                ]),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: model.connected ? mint : amber)),
              const SizedBox(width: 8),
              Text(
                  model.connected
                      ? 'LIVE TELEMETRY'
                      : model.status.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: model.connected ? mint : amber)),
              const SizedBox(width: 16),
              Chip(
                  label: Text(model.telemetry?.mode.name ?? 'OFFLINE',
                      style: const TextStyle(fontSize: 10)),
                  side: const BorderSide(color: border))
            ]),
          ]);
  Widget _metric(String title, double? value, String unit, IconData icon,
          int precision) =>
      SizedBox(
          width: 210,
          child: _card(
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(icon, size: 17, color: mint),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      color: muted, fontSize: 10, letterSpacing: 1))
            ]),
            const SizedBox(height: 18),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: value?.toStringAsFixed(precision) ?? '—',
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              TextSpan(
                  text: ' $unit',
                  style: const TextStyle(color: muted, fontSize: 13))
            ])),
          ])));
  Widget _columns(bool wide, Widget left, Widget right) => wide
      ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 7, child: left),
          const SizedBox(width: 20),
          Expanded(flex: 4, child: right)
        ])
      : Column(children: [left, const SizedBox(height: 20), right]);
  Widget _card(Widget child) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: panel,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(12)),
      child: child);
  Widget _title(String title, String detail) => Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: SizedBox(
          width: double.infinity,
          child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 16,
              runSpacing: 6,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                Text(detail, style: const TextStyle(color: muted, fontSize: 10))
              ])));
  Widget _flightPanel() => _card(Column(children: [
        _title('Flight path', 'LOCAL COORDINATES'),
        FlightMap(history: model.history, telemetry: model.telemetry)
      ]));
  Widget _missionPanel() {
    final t = model.telemetry;
    final mode = t?.mode;
    final enabled = model.connected && !model.busy;
    Widget button(String text, Command command, bool valid,
        {bool primary = false, bool confirm = false}) {
      void action() {
        if (confirm) {
          _confirm(command, text);
        } else {
          model.command(command);
        }
      }

      return SizedBox(
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: primary
                  ? FilledButton(
                      onPressed: enabled && valid ? action : null,
                      child: Text(text))
                  : OutlinedButton(
                      onPressed: enabled && valid ? action : null,
                      child: Text(text))));
    }

    return _card(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _title('Mission control', '01 / SURVEY LOOP'),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Route progress',
            style: TextStyle(color: muted, fontSize: 12)),
        Text('${((t?.missionProgress ?? 0) * 100).toStringAsFixed(0)}%')
      ]),
      const SizedBox(height: 12),
      LinearProgressIndicator(
          backgroundColor: border,
          color: mint,
          stopIndicatorColor: Colors.transparent,
          value: t?.missionProgress ?? 0,
          minHeight: 4,
          borderRadius: BorderRadius.circular(4)),
      const SizedBox(height: 24),
      button(
          mode == FlightMode.DISARMED
              ? 'Arm vehicle'
              : 'Start / resume mission',
          mode == FlightMode.DISARMED ? Command.ARM : Command.START_MISSION,
          mode == FlightMode.DISARMED ||
              mode == FlightMode.ARMED ||
              mode == FlightMode.HOLD,
          primary: true,
          confirm: mode == FlightMode.DISARMED),
      button('Hold position', Command.HOLD_POSITION,
          mode == FlightMode.MISSION || mode == FlightMode.RETURNING),
      Row(children: [
        Expanded(
            child: button('Return home', Command.RETURN_HOME,
                (t?.altitudeM ?? 0) > 0 && (t?.gpsHealthy ?? false))),
        const SizedBox(width: 8),
        Expanded(
            child: button('Land', Command.LAND, (t?.altitudeM ?? 0) > 0,
                confirm: true))
      ]),
      button('Disarm', Command.DISARM,
          mode != FlightMode.DISARMED && (t?.altitudeM ?? 1) <= 0.1),
      const SizedBox(height: 8),
      const Text('Commands acknowledged by the Rust flight simulator.',
          style: TextStyle(color: muted, fontSize: 10, height: 1.5)),
    ]));
  }

  Widget _charts() => _card(Column(children: [
        _title('Telemetry history', 'LAST 30 SECONDS'),
        Row(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('ALTITUDE / m',
                    style: TextStyle(color: muted, fontSize: 10)),
                const SizedBox(height: 12),
                TelemetryPlot(
                    values: model.history.map((t) => t.altitudeM).toList(),
                    color: mint,
                    maxValue: 100)
              ])),
          const SizedBox(width: 24),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('SPEED / m/s',
                    style: TextStyle(color: muted, fontSize: 10)),
                const SizedBox(height: 12),
                TelemetryPlot(
                    values: model.history.map((t) => t.speedMps).toList(),
                    color: const Color(0xFF7CA7F8),
                    maxValue: 20)
              ]))
        ]),
      ]));
  Widget _health() {
    final t = model.telemetry;
    Widget row(String label, String value, bool healthy) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(children: [
          Icon(Icons.circle,
              size: 6,
              color: t == null
                  ? muted
                  : healthy
                      ? mint
                      : Colors.redAccent),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: muted, fontSize: 12)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 12))
        ]));
    return _card(Column(children: [
      _title('System health', 'ONBOARD'),
      row('GPS lock', t == null ? '—' : '${t.satellites} satellites',
          t?.gpsHealthy ?? false),
      row('Battery bus', t == null ? '—' : '${t.voltage.toStringAsFixed(1)} V',
          t?.batteryHealthy ?? false),
      row('Processor', t == null ? '—' : '${t.cpuPct.toStringAsFixed(0)}%',
          true),
      row('Temperature',
          t == null ? '—' : '${t.temperatureC.toStringAsFixed(1)} °C', true),
      ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: const Text('Simulation tools',
              style: TextStyle(color: muted, fontSize: 11)),
          children: [
            Wrap(spacing: 8, children: [
              TextButton(
                  onPressed: model.connected && !model.busy
                      ? () => model.command(Command.INJECT_GPS_FAULT)
                      : null,
                  child: const Text('GPS fault')),
              TextButton(
                  onPressed: model.connected && !model.busy
                      ? () => model.command(Command.INJECT_BATTERY_FAULT)
                      : null,
                  child: const Text('Battery fault')),
              TextButton(
                  onPressed: model.connected && !model.busy
                      ? () => model.command(Command.CLEAR_FAULTS)
                      : null,
                  child: const Text('Clear faults')),
              TextButton(
                  onPressed: model.connected &&
                          !model.busy &&
                          t?.mode == FlightMode.DISARMED
                      ? () => _confirm(Command.RESET, 'Reset simulator')
                      : null,
                  child: const Text('Reset')),
            ])
          ]),
    ]));
  }

  Widget _events() =>
      _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _title('Event log', 'LATEST 12 EVENTS'),
        if (model.events.isEmpty)
          const Padding(
              padding: EdgeInsets.all(12),
              child: Text('Waiting for vehicle events…',
                  style: TextStyle(color: muted))),
        ...model.events.reversed.take(12).map((e) {
          final time =
              DateTime.fromMillisecondsSinceEpoch(e.timestampMs.toInt())
                  .toLocal()
                  .toIso8601String()
                  .substring(11, 19);
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(time,
                    style: const TextStyle(
                        color: muted, fontSize: 11, fontFamily: 'monospace')),
                const SizedBox(width: 16),
                SizedBox(
                    width: 66,
                    child: Text(e.severity.name,
                        style: TextStyle(
                            fontSize: 10,
                            color: e.severity == Severity.CRITICAL
                                ? Colors.redAccent
                                : e.severity == Severity.WARNING
                                    ? amber
                                    : mint))),
                Expanded(
                    child:
                        Text(e.message, style: const TextStyle(fontSize: 12)))
              ]));
        }),
      ]));
  Widget _banner(String message, Color color) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8)),
      child: Text(message, style: TextStyle(color: color, fontSize: 12)));
}
