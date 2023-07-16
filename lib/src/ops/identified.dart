import '../protocol/enums.dart';
import 'ops.dart';

/// The identify request was received and validated, and the connection is now
/// ready for normal operation.
class IdentifiedOpCode extends OpCode {
  int get negotiatedRpcVersion => data["negotiatedRpcVersion"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.identified;

  IdentifiedOpCode(super.data);
}
