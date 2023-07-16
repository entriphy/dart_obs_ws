import '../protocol/enums.dart';
import 'ops.dart';

/// Client is making a request to obs-websocket. Eg get current scene, create
/// source.
class RequestOpCode extends OpCode {
  String get requestType => data["requestType"];
  String get requestId => data["requestId"];
  Map<String, dynamic>? get requestData => data["requestData"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.request;

  RequestOpCode(super.data);
  RequestOpCode.create(
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
