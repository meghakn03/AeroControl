import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:fixnum/fixnum.dart';
import '../generated/aerocontrol.pbgrpc.dart';
import 'channel.dart';

enum LinkStatus { connecting, connected, reconnecting, offline }

class ControlModel extends ChangeNotifier {
  ControlModel(
      {this.endpoint = const String.fromEnvironment('API_URL',
          defaultValue: 'http://localhost:50051')});
  final String endpoint;
  Telemetry? telemetry;
  final List<Telemetry> history = [];
  final List<Event> events = [];
  LinkStatus status = LinkStatus.offline;
  String? notice;
  bool busy = false;
  bool _disposed = false;
  int _generation = 0;
  int _attempt = 0;
  Int64 _lastEvent = Int64.ZERO;
  StreamSubscription<Telemetry>? _subscription;
  Timer? _retry;
  Timer? _eventsTimer;
  Timer? _watchdog;
  DateTime? lastReceived;
  late final _channel = createChannel(endpoint);
  late final _client = GroundControlClient(_channel);
  bool get connected => status == LinkStatus.connected;

  void connect() {
    if (_disposed) return;
    _retry?.cancel();
    _subscription?.cancel();
    final generation = ++_generation;
    lastReceived = null;
    final started = DateTime.now();
    status = _attempt == 0 ? LinkStatus.connecting : LinkStatus.reconnecting;
    notifyListeners();
    _subscription = _client.watchTelemetry(Empty()).listen((value) {
      if (_disposed || generation != _generation) return;
      status = LinkStatus.connected;
      _attempt = 0;
      if (telemetry != null && value.sequence < telemetry!.sequence) {
        _lastEvent = Int64.ZERO;
        events.clear();
        history.clear();
      }
      telemetry = value;
      lastReceived = DateTime.now();
      history.add(value);
      if (history.length > 150) history.removeAt(0);
      notifyListeners();
    },
        onError: (Object error) => _lost(generation),
        onDone: () => _lost(generation));
    _eventsTimer ??=
        Timer.periodic(const Duration(seconds: 2), (_) => _loadEvents());
    _watchdog?.cancel();
    _watchdog = Timer.periodic(const Duration(seconds: 2), (_) {
      if (DateTime.now().difference(lastReceived ?? started) >
          const Duration(seconds: 5)) {
        _lost(generation);
      }
    });
  }

  void _lost(int generation) {
    if (_disposed || generation != _generation) return;
    ++_generation;
    _subscription?.cancel();
    status = LinkStatus.reconnecting;
    final seconds = min(16, 1 << min(_attempt++, 4));
    _retry?.cancel();
    _retry = Timer(Duration(seconds: seconds), connect);
    notifyListeners();
  }

  Future<void> _loadEvents() async {
    if (!connected || _disposed) return;
    try {
      final result = await _client.getEvents(EventQuery(afterId: _lastEvent),
          options: CallOptions(timeout: const Duration(seconds: 3)));
      if (_disposed) return;
      for (final event in result.events) {
        if (event.id > _lastEvent) {
          events.add(event);
          _lastEvent = event.id;
        }
      }
      if (events.length > 200) events.removeRange(0, events.length - 200);
      notifyListeners();
    } catch (_) {/* The telemetry watchdog owns link state. */}
  }

  Future<void> command(Command command) async {
    if (!connected || busy || _disposed) return;
    busy = true;
    notice = null;
    notifyListeners();
    try {
      final reply = await _client.executeCommand(
          CommandRequest(command: command),
          options: CallOptions(timeout: const Duration(seconds: 4)));
      if (_disposed) return;
      notice = reply.message;
      if (reply.hasTelemetry()) telemetry = reply.telemetry;
      await _loadEvents();
    } catch (_) {
      if (!_disposed) {
        notice =
            'Command delivery unconfirmed. Check vehicle state before retrying.';
      }
    } finally {
      if (!_disposed) {
        busy = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    ++_generation;
    _retry?.cancel();
    _eventsTimer?.cancel();
    _watchdog?.cancel();
    _subscription?.cancel();
    _channel.shutdown();
    super.dispose();
  }
}
