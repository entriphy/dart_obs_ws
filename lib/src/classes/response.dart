import 'serializable.dart';
import '../ops/request_response.dart';

class OBSWebSocketResponse extends Serializable {
  final RequestResponseStatus status;

  OBSWebSocketResponse(super.data, this.status);
}
