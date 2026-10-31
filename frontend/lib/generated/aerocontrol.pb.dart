//
//  Generated code. Do not modify.
//  source: aerocontrol.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'aerocontrol.pbenum.dart';

export 'aerocontrol.pbenum.dart';

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();
  Empty._() : super();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Empty', package: const $pb.PackageName(_omitMessageNames ? '' : 'aerocontrol.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class Telemetry extends $pb.GeneratedMessage {
  factory Telemetry({
    $fixnum.Int64? sequence,
    $fixnum.Int64? timestampMs,
    FlightMode? mode,
    $core.double? latitude,
    $core.double? longitude,
    $core.double? altitudeM,
    $core.double? speedMps,
    $core.double? headingDeg,
    $core.double? batteryPct,
    $core.double? voltage,
    $core.int? satellites,
    $core.double? cpuPct,
    $core.double? temperatureC,
    $core.bool? gpsHealthy,
    $core.bool? batteryHealthy,
    $core.double? missionProgress,
    $core.Iterable<$core.String>? alerts,
  }) {
    final $result = create();
    if (sequence != null) {
      $result.sequence = sequence;
    }
    if (timestampMs != null) {
      $result.timestampMs = timestampMs;
    }
    if (mode != null) {
      $result.mode = mode;
    }
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    if (altitudeM != null) {
      $result.altitudeM = altitudeM;
    }
    if (speedMps != null) {
      $result.speedMps = speedMps;
    }
    if (headingDeg != null) {
      $result.headingDeg = headingDeg;
    }
    if (batteryPct != null) {
      $result.batteryPct = batteryPct;
    }
    if (voltage != null) {
      $result.voltage = voltage;
    }
    if (satellites != null) {
      $result.satellites = satellites;
    }
    if (cpuPct != null) {
      $result.cpuPct = cpuPct;
    }
    if (temperatureC != null) {
      $result.temperatureC = temperatureC;
    }
    if (gpsHealthy != null) {
      $result.gpsHealthy = gpsHealthy;
    }
    if (batteryHealthy != null) {
      $result.batteryHealthy = batteryHealthy;
    }
    if (missionProgress != null) {
      $result.missionProgress = missionProgress;
    }
    if (alerts != null) {
      $result.alerts.addAll(alerts);
    }
    return $result;
  }
  Telemetry._() : super();
  factory Telemetry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Telemetry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Telemetry', package: const $pb.PackageName(_omitMessageNames ? '' : 'aerocontrol.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'sequence', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(2, _omitFieldNames ? '' : 'timestampMs')
    ..e<FlightMode>(3, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: FlightMode.DISARMED, valueOf: FlightMode.valueOf, enumValues: FlightMode.values)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'altitudeM', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'speedMps', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'headingDeg', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'batteryPct', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'voltage', $pb.PbFieldType.OD)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'satellites', $pb.PbFieldType.OU3)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'cpuPct', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'temperatureC', $pb.PbFieldType.OD)
    ..aOB(14, _omitFieldNames ? '' : 'gpsHealthy')
    ..aOB(15, _omitFieldNames ? '' : 'batteryHealthy')
    ..a<$core.double>(16, _omitFieldNames ? '' : 'missionProgress', $pb.PbFieldType.OD)
    ..pPS(17, _omitFieldNames ? '' : 'alerts')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Telemetry clone() => Telemetry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Telemetry copyWith(void Function(Telemetry) updates) => super.copyWith((message) => updates(message as Telemetry)) as Telemetry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Telemetry create() => Telemetry._();
  Telemetry createEmptyInstance() => create();
  static $pb.PbList<Telemetry> createRepeated() => $pb.PbList<Telemetry>();
  @$core.pragma('dart2js:noInline')
  static Telemetry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Telemetry>(create);
  static Telemetry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get sequence => $_getI64(0);
  @$pb.TagNumber(1)
  set sequence($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequence() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestampMs => $_getI64(1);
  @$pb.TagNumber(2)
  set timestampMs($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestampMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestampMs() => clearField(2);

  @$pb.TagNumber(3)
  FlightMode get mode => $_getN(2);
  @$pb.TagNumber(3)
  set mode(FlightMode v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMode() => $_has(2);
  @$pb.TagNumber(3)
  void clearMode() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get latitude => $_getN(3);
  @$pb.TagNumber(4)
  set latitude($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLatitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLatitude() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get longitude => $_getN(4);
  @$pb.TagNumber(5)
  set longitude($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLongitude() => $_has(4);
  @$pb.TagNumber(5)
  void clearLongitude() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get altitudeM => $_getN(5);
  @$pb.TagNumber(6)
  set altitudeM($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAltitudeM() => $_has(5);
  @$pb.TagNumber(6)
  void clearAltitudeM() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get speedMps => $_getN(6);
  @$pb.TagNumber(7)
  set speedMps($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSpeedMps() => $_has(6);
  @$pb.TagNumber(7)
  void clearSpeedMps() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get headingDeg => $_getN(7);
  @$pb.TagNumber(8)
  set headingDeg($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHeadingDeg() => $_has(7);
  @$pb.TagNumber(8)
  void clearHeadingDeg() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get batteryPct => $_getN(8);
  @$pb.TagNumber(9)
  set batteryPct($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasBatteryPct() => $_has(8);
  @$pb.TagNumber(9)
  void clearBatteryPct() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get voltage => $_getN(9);
  @$pb.TagNumber(10)
  set voltage($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasVoltage() => $_has(9);
  @$pb.TagNumber(10)
  void clearVoltage() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get satellites => $_getIZ(10);
  @$pb.TagNumber(11)
  set satellites($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSatellites() => $_has(10);
  @$pb.TagNumber(11)
  void clearSatellites() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get cpuPct => $_getN(11);
  @$pb.TagNumber(12)
  set cpuPct($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCpuPct() => $_has(11);
  @$pb.TagNumber(12)
  void clearCpuPct() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get temperatureC => $_getN(12);
  @$pb.TagNumber(13)
  set temperatureC($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasTemperatureC() => $_has(12);
  @$pb.TagNumber(13)
  void clearTemperatureC() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get gpsHealthy => $_getBF(13);
  @$pb.TagNumber(14)
  set gpsHealthy($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasGpsHealthy() => $_has(13);
  @$pb.TagNumber(14)
  void clearGpsHealthy() => clearField(14);

  @$pb.TagNumber(15)
  $core.bool get batteryHealthy => $_getBF(14);
  @$pb.TagNumber(15)
  set batteryHealthy($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasBatteryHealthy() => $_has(14);
  @$pb.TagNumber(15)
  void clearBatteryHealthy() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get missionProgress => $_getN(15);
  @$pb.TagNumber(16)
  set missionProgress($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasMissionProgress() => $_has(15);
  @$pb.TagNumber(16)
  void clearMissionProgress() => clearField(16);

  @$pb.TagNumber(17)
  $core.List<$core.String> get alerts => $_getList(16);
}

class CommandRequest extends $pb.GeneratedMessage {
  factory CommandRequest({
    Command? command,
  }) {
    final $result = create();
    if (command != null) {
      $result.command = command;
    }
    return $result;
  }
  CommandRequest._() : super();
  factory CommandRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommandRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CommandRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'aerocontrol.v1'), createEmptyInstance: create)
    ..e<Command>(1, _omitFieldNames ? '' : 'command', $pb.PbFieldType.OE, defaultOrMaker: Command.ARM, valueOf: Command.valueOf, enumValues: Command.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommandRequest clone() => CommandRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommandRequest copyWith(void Function(CommandRequest) updates) => super.copyWith((message) => updates(message as CommandRequest)) as CommandRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommandRequest create() => CommandRequest._();
  CommandRequest createEmptyInstance() => create();
  static $pb.PbList<CommandRequest> createRepeated() => $pb.PbList<CommandRequest>();
  @$core.pragma('dart2js:noInline')
  static CommandRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommandRequest>(create);
  static CommandRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Command get command => $_getN(0);
  @$pb.TagNumber(1)
  set command(Command v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCommand() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommand() => clearField(1);
}

class CommandReply extends $pb.GeneratedMessage {
  factory CommandReply({
    $core.bool? accepted,
    $core.String? message,
    Telemetry? telemetry,
  }) {
    final $result = create();
    if (accepted != null) {
      $result.accepted = accepted;
    }
    if (message != null) {
      $result.message = message;
    }
    if (telemetry != null) {
      $result.telemetry = telemetry;
    }
    return $result;
  }
  CommandReply._() : super();
  factory CommandReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommandReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CommandReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'aerocontrol.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'accepted')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<Telemetry>(3, _omitFieldNames ? '' : 'telemetry', subBuilder: Telemetry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommandReply clone() => CommandReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommandReply copyWith(void Function(CommandReply) updates) => super.copyWith((message) => updates(message as CommandReply)) as CommandReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommandReply create() => CommandReply._();
  CommandReply createEmptyInstance() => create();
  static $pb.PbList<CommandReply> createRepeated() => $pb.PbList<CommandReply>();
  @$core.pragma('dart2js:noInline')
  static CommandReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommandReply>(create);
  static CommandReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get accepted => $_getBF(0);
  @$pb.TagNumber(1)
  set accepted($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccepted() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccepted() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  Telemetry get telemetry => $_getN(2);
  @$pb.TagNumber(3)
  set telemetry(Telemetry v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTelemetry() => $_has(2);
  @$pb.TagNumber(3)
  void clearTelemetry() => clearField(3);
  @$pb.TagNumber(3)
  Telemetry ensureTelemetry() => $_ensure(2);
}

class EventQuery extends $pb.GeneratedMessage {
  factory EventQuery({
    $fixnum.Int64? afterId,
  }) {
    final $result = create();
    if (afterId != null) {
      $result.afterId = afterId;
    }
    return $result;
  }
  EventQuery._() : super();
  factory EventQuery.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EventQuery.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EventQuery', package: const $pb.PackageName(_omitMessageNames ? '' : 'aerocontrol.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'afterId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EventQuery clone() => EventQuery()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EventQuery copyWith(void Function(EventQuery) updates) => super.copyWith((message) => updates(message as EventQuery)) as EventQuery;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventQuery create() => EventQuery._();
  EventQuery createEmptyInstance() => create();
  static $pb.PbList<EventQuery> createRepeated() => $pb.PbList<EventQuery>();
  @$core.pragma('dart2js:noInline')
  static EventQuery getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventQuery>(create);
  static EventQuery? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get afterId => $_getI64(0);
  @$pb.TagNumber(1)
  set afterId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAfterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAfterId() => clearField(1);
}

class Event extends $pb.GeneratedMessage {
  factory Event({
    $fixnum.Int64? id,
    $fixnum.Int64? timestampMs,
    Severity? severity,
    $core.String? message,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (timestampMs != null) {
      $result.timestampMs = timestampMs;
    }
    if (severity != null) {
      $result.severity = severity;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Event._() : super();
  factory Event.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Event.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Event', package: const $pb.PackageName(_omitMessageNames ? '' : 'aerocontrol.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(2, _omitFieldNames ? '' : 'timestampMs')
    ..e<Severity>(3, _omitFieldNames ? '' : 'severity', $pb.PbFieldType.OE, defaultOrMaker: Severity.INFO, valueOf: Severity.valueOf, enumValues: Severity.values)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event)) as Event;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestampMs => $_getI64(1);
  @$pb.TagNumber(2)
  set timestampMs($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestampMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestampMs() => clearField(2);

  @$pb.TagNumber(3)
  Severity get severity => $_getN(2);
  @$pb.TagNumber(3)
  set severity(Severity v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSeverity() => $_has(2);
  @$pb.TagNumber(3)
  void clearSeverity() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class EventLog extends $pb.GeneratedMessage {
  factory EventLog({
    $core.Iterable<Event>? events,
  }) {
    final $result = create();
    if (events != null) {
      $result.events.addAll(events);
    }
    return $result;
  }
  EventLog._() : super();
  factory EventLog.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EventLog.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EventLog', package: const $pb.PackageName(_omitMessageNames ? '' : 'aerocontrol.v1'), createEmptyInstance: create)
    ..pc<Event>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: Event.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EventLog clone() => EventLog()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EventLog copyWith(void Function(EventLog) updates) => super.copyWith((message) => updates(message as EventLog)) as EventLog;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventLog create() => EventLog._();
  EventLog createEmptyInstance() => create();
  static $pb.PbList<EventLog> createRepeated() => $pb.PbList<EventLog>();
  @$core.pragma('dart2js:noInline')
  static EventLog getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventLog>(create);
  static EventLog? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Event> get events => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
