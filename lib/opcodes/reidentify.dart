import '../protocol/enums.dart';
import 'opcodes.dart';

/// Sent at any time after initial identification to update the provided session
/// parameters.
class ReidentifyOpCode extends OpCode {
  int get eventSubscriptions => data["eventSubscriptions"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.reidentify;

  ReidentifyOpCode(super.data);
  ReidentifyOpCode.create(int eventSubscriptions)
      : super({"eventSubscriptions": eventSubscriptions});
}
