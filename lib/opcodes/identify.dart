import '../protocol/enums.dart';
import 'opcodes.dart';

/// Response to `Hello` message, should contain authentication string if
/// authentication is required, along with PubSub subscriptions and other
/// session parameters.
class IdentifyOpCode extends OpCode {
  int get rpcVersion => data["rpcVersion"];
  String? get authentication => data["authentication"];
  int? get eventSubscriptions => data["eventSubscriptions"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.identify;

  IdentifyOpCode(super.data);
  IdentifyOpCode.create(
      {required int rpcVersion,
      String? authentication,
      int? eventSubscriptions})
      : super({
          "rpcVersion": rpcVersion,
          if (authentication != null) "authentication": authentication,
          if (eventSubscriptions != null)
            "eventSubscriptions": eventSubscriptions
        });
}
