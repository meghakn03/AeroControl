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

import 'package:protobuf/protobuf.dart' as $pb;

class FlightMode extends $pb.ProtobufEnum {
  static const FlightMode DISARMED = FlightMode._(0, _omitEnumNames ? '' : 'DISARMED');
  static const FlightMode ARMED = FlightMode._(1, _omitEnumNames ? '' : 'ARMED');
  static const FlightMode MISSION = FlightMode._(2, _omitEnumNames ? '' : 'MISSION');
  static const FlightMode HOLD = FlightMode._(3, _omitEnumNames ? '' : 'HOLD');
  static const FlightMode RETURNING = FlightMode._(4, _omitEnumNames ? '' : 'RETURNING');
  static const FlightMode LANDING = FlightMode._(5, _omitEnumNames ? '' : 'LANDING');

  static const $core.List<FlightMode> values = <FlightMode> [
    DISARMED,
    ARMED,
    MISSION,
    HOLD,
    RETURNING,
    LANDING,
  ];

  static final $core.Map<$core.int, FlightMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FlightMode? valueOf($core.int value) => _byValue[value];

  const FlightMode._($core.int v, $core.String n) : super(v, n);
}

class Command extends $pb.ProtobufEnum {
  static const Command ARM = Command._(0, _omitEnumNames ? '' : 'ARM');
  static const Command DISARM = Command._(1, _omitEnumNames ? '' : 'DISARM');
  static const Command START_MISSION = Command._(2, _omitEnumNames ? '' : 'START_MISSION');
  static const Command HOLD_POSITION = Command._(3, _omitEnumNames ? '' : 'HOLD_POSITION');
  static const Command RETURN_HOME = Command._(4, _omitEnumNames ? '' : 'RETURN_HOME');
  static const Command LAND = Command._(5, _omitEnumNames ? '' : 'LAND');
  static const Command INJECT_GPS_FAULT = Command._(6, _omitEnumNames ? '' : 'INJECT_GPS_FAULT');
  static const Command INJECT_BATTERY_FAULT = Command._(7, _omitEnumNames ? '' : 'INJECT_BATTERY_FAULT');
  static const Command CLEAR_FAULTS = Command._(8, _omitEnumNames ? '' : 'CLEAR_FAULTS');
  static const Command RESET = Command._(9, _omitEnumNames ? '' : 'RESET');

  static const $core.List<Command> values = <Command> [
    ARM,
    DISARM,
    START_MISSION,
    HOLD_POSITION,
    RETURN_HOME,
    LAND,
    INJECT_GPS_FAULT,
    INJECT_BATTERY_FAULT,
    CLEAR_FAULTS,
    RESET,
  ];

  static final $core.Map<$core.int, Command> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Command? valueOf($core.int value) => _byValue[value];

  const Command._($core.int v, $core.String n) : super(v, n);
}

class Severity extends $pb.ProtobufEnum {
  static const Severity INFO = Severity._(0, _omitEnumNames ? '' : 'INFO');
  static const Severity WARNING = Severity._(1, _omitEnumNames ? '' : 'WARNING');
  static const Severity CRITICAL = Severity._(2, _omitEnumNames ? '' : 'CRITICAL');

  static const $core.List<Severity> values = <Severity> [
    INFO,
    WARNING,
    CRITICAL,
  ];

  static final $core.Map<$core.int, Severity> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Severity? valueOf($core.int value) => _byValue[value];

  const Severity._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
