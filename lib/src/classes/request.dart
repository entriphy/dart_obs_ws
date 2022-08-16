import 'serializable.dart';
import 'response.dart';
import '../protocol/responses.dart';

class OBSWebSocketRequest<T extends OBSWebSocketResponse> extends Serializable {
  final String type;

  T? response;

  OBSWebSocketRequest(this.type, [Map<String, dynamic>? data])
      : super(data ?? {});

  OBSWebSocketResponse serializeResponse(data, status) =>
      OBSWebSocketResponse(data, status);
}

/// Yeet
class GetSceneListRequest extends OBSWebSocketRequest<GetSceneListResponse> {
  GetSceneListRequest() : super("GetSceneList");

  @override
  GetSceneListResponse serializeResponse(data, status) =>
      GetSceneListResponse(data, status);
}
