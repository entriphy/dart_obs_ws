import '../classes/serializable.dart';
import '../protocol/enums.dart';

import 'ops.dart';

/// obs-websocket is responding to a request coming from a client.
class ObsRequestResponseOp extends ObsOp {
  String get requestType => data["requestType"];
  String get requestId => data["requestId"];
  ObsRequestResponseStatus get requestStatus =>
      ObsRequestResponseStatus(data["requestStatus"]);
  Map<String, dynamic>? get responseData => data["responseData"];

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.requestResponse;

  ObsRequestResponseOp(super.data);
}

class ObsRequestResponseStatus extends Serializable {
  bool get result => data["result"];
  ObsRequestStatus get code => ObsRequestStatus.fromInt(data["code"]);
  String? get comment => data["comment"];

  ObsRequestResponseStatus(super.data);
}
