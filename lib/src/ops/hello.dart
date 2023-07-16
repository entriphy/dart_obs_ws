import '../protocol/enums.dart';
import '../classes/serializable.dart';
import 'ops.dart';

/// First message sent from the server immediately on client connection.
/// Contains authentication information if auth is required.
/// Also contains RPC version for version negotiation.
class HelloOpCode extends OpCode {
  /// obs-websocket version of the host
  String get obsWebSocketVersion => data["obsWebSocketVersion"];

  /// RPC version of the host
  int get rpcVersion => data["rpcVersion"];

  /// Authentication info (if applicable)
  HelloAuthentication? get authentication => data.containsKey("authentication")
      ? HelloAuthentication(data["authentication"])
      : null;

  @override
  WebSocketOpCode get code => WebSocketOpCode.hello;

  HelloOpCode(super.data);
}

/// Authentication info sent by HelloOp required to the authenticate the client
/// to the host
class HelloAuthentication extends Serializable {
  String get challenge => data["challenge"];
  String get salt => data["salt"];

  HelloAuthentication(super.data);
}
