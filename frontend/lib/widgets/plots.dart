import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../generated/aerocontrol.pb.dart';

const mint = Color(0xFF65E2BE);
const muted = Color(0xFF8C9BAC);

class TelemetryPlot extends StatelessWidget {
  const TelemetryPlot(
      {super.key,
      required this.values,
      required this.color,
      required this.maxValue});
  final List<double> values;
  final Color color;
  final double maxValue;
  @override
  Widget build(BuildContext context) => SizedBox(
      height: 105,
      child: CustomPaint(
          painter: _PlotPainter(values, color, maxValue), size: Size.infinite));
}

class _PlotPainter extends CustomPainter {
  _PlotPainter(this.values, this.color, this.maxValue);
  final List<double> values;
  final Color color;
  final double maxValue;
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1;
    for (var i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    if (values.length < 2) return;
    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final y = size.height * (1 - (values[i] / maxValue).clamp(0, 1));
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final fill = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
        fill,
        Paint()
          ..shader = LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withValues(alpha: 0.25),
                color.withValues(alpha: 0)
              ]).createShader(Offset.zero & size));
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant _PlotPainter oldDelegate) => true;
}

class FlightMap extends StatelessWidget {
  const FlightMap({super.key, required this.history, this.telemetry});
  final List<Telemetry> history;
  final Telemetry? telemetry;
  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
          height: 320,
          child: Stack(children: [
            Positioned.fill(
                child: CustomPaint(painter: _MapPainter(history, telemetry))),
            const Positioned(
                left: 18,
                top: 16,
                child: Text('LOCAL FLIGHT SPACE',
                    style: TextStyle(
                        color: muted, fontSize: 10, letterSpacing: 2))),
            const Positioned(
                right: 18,
                top: 16,
                child: Text('N ↑', style: TextStyle(color: mint))),
            Positioned(
                left: 18,
                bottom: 16,
                child: Text(
                    telemetry == null
                        ? 'Awaiting position…'
                        : '${telemetry!.latitude.toStringAsFixed(5)}° N   ${telemetry!.longitude.toStringAsFixed(5)}° E',
                    style: const TextStyle(
                        fontSize: 11, color: muted, fontFamily: 'monospace'))),
            const Positioned(
                right: 18,
                bottom: 16,
                child: Text('SCHEMATIC · 1 km',
                    style: TextStyle(fontSize: 9, color: muted))),
          ])));
}

class _MapPainter extends CustomPainter {
  _MapPainter(this.history, this.telemetry);
  final List<Telemetry> history;
  final Telemetry? telemetry;
  Offset point(Telemetry t, Size size) => Offset(
      size.width * (0.22 + (t.longitude + 0.1278) / 0.012),
      size.height * (0.5 - (t.latitude - 51.5074) / 0.009));
  @override
  void paint(Canvas canvas, Size s) {
    canvas.drawRect(Offset.zero & s, Paint()..color = const Color(0xFF0D1A22));
    final grid = Paint()
      ..color = const Color(0xFF1B2C35)
      ..strokeWidth = 1;
    for (double x = 0; x < s.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, s.height), grid);
    }
    for (double y = 0; y < s.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(s.width, y), grid);
    }
    final home = Offset(s.width * 0.22, s.height * 0.5);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(s.width * (0.22 + 0.004 / 0.012), s.height * 0.5),
            width: s.width * 0.008 / 0.012,
            height: s.height * 0.006 / 0.009),
        Paint()
          ..color = mint.withValues(alpha: 0.16)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5);
    canvas.drawCircle(home, 7, Paint()..color = muted);
    canvas.drawCircle(home, 3, Paint()..color = const Color(0xFF0D1A22));
    if (history.isNotEmpty) {
      final path = Path()
        ..moveTo(point(history.first, s).dx, point(history.first, s).dy);
      for (final t in history.skip(1)) {
        final p = point(t, s);
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(
          path,
          Paint()
            ..color = mint
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    }
    if (telemetry != null) {
      final p = point(telemetry!, s);
      canvas.drawCircle(p, 22, Paint()..color = mint.withValues(alpha: 0.1));
      canvas.save();
      canvas.translate(p.dx, p.dy);
      canvas.rotate(telemetry!.headingDeg * math.pi / 180);
      canvas.drawPath(
          Path()
            ..moveTo(0, -12)
            ..lineTo(8, 9)
            ..lineTo(0, 5)
            ..lineTo(-8, 9)
            ..close(),
          Paint()..color = mint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) => true;
}
