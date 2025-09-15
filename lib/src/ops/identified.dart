import '../protocol/enums.dart';
import 'ops.dart';

/// The identify request was received and validated, and the connection is now
/// ready for normal operation.
class ObsIdentifiedOp extends ObsOp {
  int get negotiatedRpcVersion => data["negotiatedRpcVersion"];

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.identified;

  ObsIdentifiedOp(super.data);
}
