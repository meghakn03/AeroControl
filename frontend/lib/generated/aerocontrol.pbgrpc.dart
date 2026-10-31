//
//  Generated code. Do not modify.
//  source: aerocontrol.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'aerocontrol.pb.dart' as $0;

export 'aerocontrol.pb.dart';

@$pb.GrpcServiceName('aerocontrol.v1.GroundControl')
class GroundControlClient extends $grpc.Client {
  static final _$getSnapshot = $grpc.ClientMethod<$0.Empty, $0.Telemetry>(
      '/aerocontrol.v1.GroundControl/GetSnapshot',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Telemetry.fromBuffer(value));
  static final _$watchTelemetry = $grpc.ClientMethod<$0.Empty, $0.Telemetry>(
      '/aerocontrol.v1.GroundControl/WatchTelemetry',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Telemetry.fromBuffer(value));
  static final _$executeCommand = $grpc.ClientMethod<$0.CommandRequest, $0.CommandReply>(
      '/aerocontrol.v1.GroundControl/ExecuteCommand',
      ($0.CommandRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CommandReply.fromBuffer(value));
  static final _$getEvents = $grpc.ClientMethod<$0.EventQuery, $0.EventLog>(
      '/aerocontrol.v1.GroundControl/GetEvents',
      ($0.EventQuery value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.EventLog.fromBuffer(value));

  GroundControlClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.Telemetry> getSnapshot($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSnapshot, request, options: options);
  }

  $grpc.ResponseStream<$0.Telemetry> watchTelemetry($0.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$watchTelemetry, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.CommandReply> executeCommand($0.CommandRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$executeCommand, request, options: options);
  }

  $grpc.ResponseFuture<$0.EventLog> getEvents($0.EventQuery request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEvents, request, options: options);
  }
}

@$pb.GrpcServiceName('aerocontrol.v1.GroundControl')
abstract class GroundControlServiceBase extends $grpc.Service {
  $core.String get $name => 'aerocontrol.v1.GroundControl';

  GroundControlServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Telemetry>(
        'GetSnapshot',
        getSnapshot_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Telemetry value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Telemetry>(
        'WatchTelemetry',
        watchTelemetry_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Telemetry value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CommandRequest, $0.CommandReply>(
        'ExecuteCommand',
        executeCommand_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CommandRequest.fromBuffer(value),
        ($0.CommandReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EventQuery, $0.EventLog>(
        'GetEvents',
        getEvents_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EventQuery.fromBuffer(value),
        ($0.EventLog value) => value.writeToBuffer()));
  }

  $async.Future<$0.Telemetry> getSnapshot_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getSnapshot(call, await request);
  }

  $async.Stream<$0.Telemetry> watchTelemetry_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* watchTelemetry(call, await request);
  }

  $async.Future<$0.CommandReply> executeCommand_Pre($grpc.ServiceCall call, $async.Future<$0.CommandRequest> request) async {
    return executeCommand(call, await request);
  }

  $async.Future<$0.EventLog> getEvents_Pre($grpc.ServiceCall call, $async.Future<$0.EventQuery> request) async {
    return getEvents(call, await request);
  }

  $async.Future<$0.Telemetry> getSnapshot($grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$0.Telemetry> watchTelemetry($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.CommandReply> executeCommand($grpc.ServiceCall call, $0.CommandRequest request);
  $async.Future<$0.EventLog> getEvents($grpc.ServiceCall call, $0.EventQuery request);
}
