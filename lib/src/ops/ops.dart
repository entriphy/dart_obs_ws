import '../obs_websocket.dart';
import '../classes/serializable.dart';
import 'ops.dart';

export 'hello.dart';
export 'identified.dart';
export 'identify.dart';
export 'reidentify.dart';
export 'event.dart';
export 'request.dart';
export 'request_response.dart';
export 'request_batch.dart';
export 'request_batch_response.dart';

abstract class OpCode extends Serializable {
  WebSocketOpCode get code;

  OpCode(super.data);

  static const Map<WebSocketOpCode, OpCode Function(Map<String, dynamic> data)>
      // ignore: constant_identifier_names
      OpCodeMap = {
    WebSocketOpCode.hello: HelloOp.new,
    WebSocketOpCode.identify: IdentifyOp.new,
    WebSocketOpCode.identified: IdentifiedOp.new,
    WebSocketOpCode.reidentify: ReidentifyOp.new,
    WebSocketOpCode.event: EventOp.new,
    WebSocketOpCode.request: RequestOp.new,
    WebSocketOpCode.requestResponse: RequestResponseOp.new,
    WebSocketOpCode.requestBatch: RequestBatchOp.new,
    WebSocketOpCode.requestBatchResponse: RequestBatchResponseOp.new
  };
}
