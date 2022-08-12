import '../protocol/enums.dart';
import '../classes/serializable.dart';
import 'opcodes.dart';

/// First message sent from the server immediately on client connection.
/// Contains authentication information if auth is required.
/// Also contains RPC version for version negotiation.
class HelloOpCode extends OpCode {
  String get obsWebSocketVersion => data["obsWebSocketVersion"];
  int get rpcVersion => data["rpcVersion"];
  Authentication? get authentication => data.containsKey("authentication")
      ? Authentication(data["authentication"])
      : null;

  @override
  WebSocketOpCode get code => WebSocketOpCode.hello;

  HelloOpCode(super.data);
}

class Authentication extends Serializable {
  String get challenge => data["challenge"];
  String get salt => data["salt"];

  Authentication(super.data);
}
