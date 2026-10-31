//
//  Generated code. Do not modify.
//  source: aerocontrol.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use flightModeDescriptor instead')
const FlightMode$json = {
  '1': 'FlightMode',
  '2': [
    {'1': 'DISARMED', '2': 0},
    {'1': 'ARMED', '2': 1},
    {'1': 'MISSION', '2': 2},
    {'1': 'HOLD', '2': 3},
    {'1': 'RETURNING', '2': 4},
    {'1': 'LANDING', '2': 5},
  ],
};

/// Descriptor for `FlightMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List flightModeDescriptor = $convert.base64Decode(
    'CgpGbGlnaHRNb2RlEgwKCERJU0FSTUVEEAASCQoFQVJNRUQQARILCgdNSVNTSU9OEAISCAoESE'
    '9MRBADEg0KCVJFVFVSTklORxAEEgsKB0xBTkRJTkcQBQ==');

@$core.Deprecated('Use commandDescriptor instead')
const Command$json = {
  '1': 'Command',
  '2': [
    {'1': 'ARM', '2': 0},
    {'1': 'DISARM', '2': 1},
    {'1': 'START_MISSION', '2': 2},
    {'1': 'HOLD_POSITION', '2': 3},
    {'1': 'RETURN_HOME', '2': 4},
    {'1': 'LAND', '2': 5},
    {'1': 'INJECT_GPS_FAULT', '2': 6},
    {'1': 'INJECT_BATTERY_FAULT', '2': 7},
    {'1': 'CLEAR_FAULTS', '2': 8},
    {'1': 'RESET', '2': 9},
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode(
    'CgdDb21tYW5kEgcKA0FSTRAAEgoKBkRJU0FSTRABEhEKDVNUQVJUX01JU1NJT04QAhIRCg1IT0'
    'xEX1BPU0lUSU9OEAMSDwoLUkVUVVJOX0hPTUUQBBIICgRMQU5EEAUSFAoQSU5KRUNUX0dQU19G'
    'QVVMVBAGEhgKFElOSkVDVF9CQVRURVJZX0ZBVUxUEAcSEAoMQ0xFQVJfRkFVTFRTEAgSCQoFUk'
    'VTRVQQCQ==');

@$core.Deprecated('Use severityDescriptor instead')
const Severity$json = {
  '1': 'Severity',
  '2': [
    {'1': 'INFO', '2': 0},
    {'1': 'WARNING', '2': 1},
    {'1': 'CRITICAL', '2': 2},
  ],
};

/// Descriptor for `Severity`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List severityDescriptor = $convert.base64Decode(
    'CghTZXZlcml0eRIICgRJTkZPEAASCwoHV0FSTklORxABEgwKCENSSVRJQ0FMEAI=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use telemetryDescriptor instead')
const Telemetry$json = {
  '1': 'Telemetry',
  '2': [
    {'1': 'sequence', '3': 1, '4': 1, '5': 4, '10': 'sequence'},
    {'1': 'timestamp_ms', '3': 2, '4': 1, '5': 3, '10': 'timestampMs'},
    {'1': 'mode', '3': 3, '4': 1, '5': 14, '6': '.aerocontrol.v1.FlightMode', '10': 'mode'},
    {'1': 'latitude', '3': 4, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 5, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'altitude_m', '3': 6, '4': 1, '5': 1, '10': 'altitudeM'},
    {'1': 'speed_mps', '3': 7, '4': 1, '5': 1, '10': 'speedMps'},
    {'1': 'heading_deg', '3': 8, '4': 1, '5': 1, '10': 'headingDeg'},
    {'1': 'battery_pct', '3': 9, '4': 1, '5': 1, '10': 'batteryPct'},
    {'1': 'voltage', '3': 10, '4': 1, '5': 1, '10': 'voltage'},
    {'1': 'satellites', '3': 11, '4': 1, '5': 13, '10': 'satellites'},
    {'1': 'cpu_pct', '3': 12, '4': 1, '5': 1, '10': 'cpuPct'},
    {'1': 'temperature_c', '3': 13, '4': 1, '5': 1, '10': 'temperatureC'},
    {'1': 'gps_healthy', '3': 14, '4': 1, '5': 8, '10': 'gpsHealthy'},
    {'1': 'battery_healthy', '3': 15, '4': 1, '5': 8, '10': 'batteryHealthy'},
    {'1': 'mission_progress', '3': 16, '4': 1, '5': 1, '10': 'missionProgress'},
    {'1': 'alerts', '3': 17, '4': 3, '5': 9, '10': 'alerts'},
  ],
};

/// Descriptor for `Telemetry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List telemetryDescriptor = $convert.base64Decode(
    'CglUZWxlbWV0cnkSGgoIc2VxdWVuY2UYASABKARSCHNlcXVlbmNlEiEKDHRpbWVzdGFtcF9tcx'
    'gCIAEoA1ILdGltZXN0YW1wTXMSLgoEbW9kZRgDIAEoDjIaLmFlcm9jb250cm9sLnYxLkZsaWdo'
    'dE1vZGVSBG1vZGUSGgoIbGF0aXR1ZGUYBCABKAFSCGxhdGl0dWRlEhwKCWxvbmdpdHVkZRgFIA'
    'EoAVIJbG9uZ2l0dWRlEh0KCmFsdGl0dWRlX20YBiABKAFSCWFsdGl0dWRlTRIbCglzcGVlZF9t'
    'cHMYByABKAFSCHNwZWVkTXBzEh8KC2hlYWRpbmdfZGVnGAggASgBUgpoZWFkaW5nRGVnEh8KC2'
    'JhdHRlcnlfcGN0GAkgASgBUgpiYXR0ZXJ5UGN0EhgKB3ZvbHRhZ2UYCiABKAFSB3ZvbHRhZ2US'
    'HgoKc2F0ZWxsaXRlcxgLIAEoDVIKc2F0ZWxsaXRlcxIXCgdjcHVfcGN0GAwgASgBUgZjcHVQY3'
    'QSIwoNdGVtcGVyYXR1cmVfYxgNIAEoAVIMdGVtcGVyYXR1cmVDEh8KC2dwc19oZWFsdGh5GA4g'
    'ASgIUgpncHNIZWFsdGh5EicKD2JhdHRlcnlfaGVhbHRoeRgPIAEoCFIOYmF0dGVyeUhlYWx0aH'
    'kSKQoQbWlzc2lvbl9wcm9ncmVzcxgQIAEoAVIPbWlzc2lvblByb2dyZXNzEhYKBmFsZXJ0cxgR'
    'IAMoCVIGYWxlcnRz');

@$core.Deprecated('Use commandRequestDescriptor instead')
const CommandRequest$json = {
  '1': 'CommandRequest',
  '2': [
    {'1': 'command', '3': 1, '4': 1, '5': 14, '6': '.aerocontrol.v1.Command', '10': 'command'},
  ],
};

/// Descriptor for `CommandRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandRequestDescriptor = $convert.base64Decode(
    'Cg5Db21tYW5kUmVxdWVzdBIxCgdjb21tYW5kGAEgASgOMhcuYWVyb2NvbnRyb2wudjEuQ29tbW'
    'FuZFIHY29tbWFuZA==');

@$core.Deprecated('Use commandReplyDescriptor instead')
const CommandReply$json = {
  '1': 'CommandReply',
  '2': [
    {'1': 'accepted', '3': 1, '4': 1, '5': 8, '10': 'accepted'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'telemetry', '3': 3, '4': 1, '5': 11, '6': '.aerocontrol.v1.Telemetry', '10': 'telemetry'},
  ],
};

/// Descriptor for `CommandReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandReplyDescriptor = $convert.base64Decode(
    'CgxDb21tYW5kUmVwbHkSGgoIYWNjZXB0ZWQYASABKAhSCGFjY2VwdGVkEhgKB21lc3NhZ2UYAi'
    'ABKAlSB21lc3NhZ2USNwoJdGVsZW1ldHJ5GAMgASgLMhkuYWVyb2NvbnRyb2wudjEuVGVsZW1l'
    'dHJ5Ugl0ZWxlbWV0cnk=');

@$core.Deprecated('Use eventQueryDescriptor instead')
const EventQuery$json = {
  '1': 'EventQuery',
  '2': [
    {'1': 'after_id', '3': 1, '4': 1, '5': 4, '10': 'afterId'},
  ],
};

/// Descriptor for `EventQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventQueryDescriptor = $convert.base64Decode(
    'CgpFdmVudFF1ZXJ5EhkKCGFmdGVyX2lkGAEgASgEUgdhZnRlcklk');

@$core.Deprecated('Use eventDescriptor instead')
const Event$json = {
  '1': 'Event',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'timestamp_ms', '3': 2, '4': 1, '5': 3, '10': 'timestampMs'},
    {'1': 'severity', '3': 3, '4': 1, '5': 14, '6': '.aerocontrol.v1.Severity', '10': 'severity'},
    {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIOCgJpZBgBIAEoBFICaWQSIQoMdGltZXN0YW1wX21zGAIgASgDUgt0aW1lc3RhbX'
    'BNcxI0CghzZXZlcml0eRgDIAEoDjIYLmFlcm9jb250cm9sLnYxLlNldmVyaXR5UghzZXZlcml0'
    'eRIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use eventLogDescriptor instead')
const EventLog$json = {
  '1': 'EventLog',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.aerocontrol.v1.Event', '10': 'events'},
  ],
};

/// Descriptor for `EventLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventLogDescriptor = $convert.base64Decode(
    'CghFdmVudExvZxItCgZldmVudHMYASADKAsyFS5hZXJvY29udHJvbC52MS5FdmVudFIGZXZlbn'
    'Rz');

