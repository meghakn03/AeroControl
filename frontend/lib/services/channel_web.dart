import 'package:grpc/grpc_web.dart';

GrpcWebClientChannel createChannel(String endpoint) =>
    GrpcWebClientChannel.xhr(Uri.parse(endpoint));
