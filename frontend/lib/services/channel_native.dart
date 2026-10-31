import 'package:grpc/grpc.dart';

ClientChannel createChannel(String endpoint) {
  final uri = Uri.parse(endpoint);
  return ClientChannel(uri.host,
      port: uri.port,
      options: ChannelOptions(
          credentials: uri.scheme == 'https'
              ? const ChannelCredentials.secure()
              : const ChannelCredentials.insecure()));
}
