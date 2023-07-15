import 'serializable.dart';
import 'response.dart';

abstract class OBSWebSocketRequest<T extends OBSWebSocketResponse>
    extends Serializable {
  final String type;

  T? response;

  OBSWebSocketRequest(this.type, [Map<String, dynamic>? data])
      : super(data ?? {});

  OBSWebSocketResponse serializeResponse(data, status) =>
      OBSWebSocketResponse(data, status);
}
