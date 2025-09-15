import '../protocol/enums.dart';
import 'ops.dart';

/// Response to `Hello` message, should contain authentication string if
/// authentication is required, along with PubSub subscriptions and other
/// session parameters.
class ObsIdentifyOp extends ObsOp {
  int get rpcVersion => data["rpcVersion"];
  String? get authentication => data["authentication"];
  int? get eventSubscriptions => data["eventSubscriptions"];

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.identify;

  ObsIdentifyOp(super.data);
  ObsIdentifyOp.create(
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
