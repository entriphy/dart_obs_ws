import '../obs_websocket.dart';
import '../classes/serializable.dart';

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
      opCodeMap = {
    WebSocketOpCode.hello: HelloOpCode.new,
    WebSocketOpCode.identify: IdentifyOpCode.new,
    WebSocketOpCode.identified: IdentifiedOpCode.new,
    WebSocketOpCode.reidentify: ReidentifyOpCode.new,
    WebSocketOpCode.event: EventOpCode.new,
    WebSocketOpCode.request: RequestOpCode.new,
    WebSocketOpCode.requestResponse: RequestResponseOpCode.new,
    WebSocketOpCode.requestBatch: RequestBatchOpCode.new,
    WebSocketOpCode.requestBatchResponse: RequestBatchResponseOpCode.new
  };
}
