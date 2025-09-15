import '../obs_websocket.dart';
import '../classes/serializable.dart';

export 'hello.dart';
export 'identify.dart';
export 'identified.dart';
export 'reidentify.dart';
export 'event.dart';
export 'request.dart';
export 'request_response.dart';
export 'request_batch.dart';
export 'request_batch_response.dart';

abstract class ObsOp extends Serializable {
  ObsWebSocketOpCode get code;

  ObsOp(super.data);

  static const Map<ObsWebSocketOpCode,
      ObsOp Function(Map<String, dynamic> data)> opCodeMap = {
    ObsWebSocketOpCode.hello: ObsHelloOp.new,
    ObsWebSocketOpCode.identify: ObsIdentifyOp.new,
    ObsWebSocketOpCode.identified: ObsIdentifiedOp.new,
    ObsWebSocketOpCode.reidentify: ObsReidentifyOp.new,
    ObsWebSocketOpCode.event: ObsEventOp.new,
    ObsWebSocketOpCode.request: ObsRequestOp.new,
    ObsWebSocketOpCode.requestResponse: ObsRequestResponseOp.new,
    ObsWebSocketOpCode.requestBatch: ObsRequestBatchOp.new,
    ObsWebSocketOpCode.requestBatchResponse: ObsRequestBatchResponseOp.new
  };
}
