import '../protocol/enums.dart';
import 'ops.dart';

/// Client is making a request to obs-websocket. Eg get current scene, create
/// source.
class ObsRequestOp extends ObsOp {
  String get requestType => data["requestType"];
  String get requestId => data["requestId"];
  Map<String, dynamic>? get requestData => data["requestData"];

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.request;

  ObsRequestOp(super.data);
  ObsRequestOp.create(
      {required String requestType,
      required String requestId,
      Map<String, dynamic>? requestData})
      : super({
          "requestType": requestType,
          "requestId": requestId,
          if (requestData != null && requestData.isNotEmpty)
            "requestData": requestData
        });
}
