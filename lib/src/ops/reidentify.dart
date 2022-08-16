import '../protocol/enums.dart';
import 'ops.dart';

/// Sent at any time after initial identification to update the provided session
/// parameters.
class ReidentifyOp extends OpCode {
  int get eventSubscriptions => data["eventSubscriptions"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.reidentify;

  ReidentifyOp(super.data);
  ReidentifyOp.create(int eventSubscriptions)
      : super({"eventSubscriptions": eventSubscriptions});
}
