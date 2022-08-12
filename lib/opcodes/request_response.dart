import '../classes/serializable.dart';
import '../protocol/enums.dart';

import 'opcodes.dart';

/// obs-websocket is responding to a request coming from a client.
class RequestResponseOpCode extends OpCode {
  String get requestType => data["requestType"];
  String get requestId => data["requestId"];
  RequestResponseStatus get requestStatus =>
      RequestResponseStatus(data["requestStatus"]);
  Map<String, dynamic>? get responseData => data["responseData"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.requestResponse;

  RequestResponseOpCode(super.data);
}

class RequestResponseStatus extends Serializable {
  bool get result => data["result"];
  RequestStatus get code => RequestStatus.fromInt(data["code"]);
  String? get comment => data["comment"];

  RequestResponseStatus(super.data);
}
