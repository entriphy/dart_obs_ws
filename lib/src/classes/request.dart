import 'serializable.dart';
import 'response.dart';

abstract class ObsWebSocketRequest<T extends ObsWebSocketResponse>
    extends Serializable {
  final String type;

  T? response;

  ObsWebSocketRequest(this.type, [Map<String, dynamic>? data])
      : super(data ?? {});

  ObsWebSocketResponse serializeResponse(data, status) =>
      ObsWebSocketResponse(data, status);
}
