import '../protocol/enums.dart';

import 'ops.dart';

/// obs-websocket is responding to a request batch coming from the client.
class RequestBatchResponseOpCode extends OpCode {
  String get requestId => data["requestId"];
  List<RequestResponseOpCode> get results => data["results"]
      .map<RequestResponseOpCode>((d) => RequestResponseOpCode(d))
      .toList();

  @override
  WebSocketOpCode get code => WebSocketOpCode.requestBatchResponse;

  RequestBatchResponseOpCode(super.data);
}
