import '../protocol/enums.dart';
import 'ops.dart';

/// Sent at any time after initial identification to update the provided session
/// parameters.
class ObsReidentifyOp extends ObsOp {
  int get eventSubscriptions => data["eventSubscriptions"];

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.reidentify;

  ObsReidentifyOp(super.data);
  ObsReidentifyOp.create(int eventSubscriptions)
      : super({"eventSubscriptions": eventSubscriptions});
}
