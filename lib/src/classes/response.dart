import 'serializable.dart';
import '../ops/request_response.dart';

class ObsWebSocketResponse extends Serializable {
  final ObsRequestResponseStatus status;

  ObsWebSocketResponse(super.data, this.status);
}
