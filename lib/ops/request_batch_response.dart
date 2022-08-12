import '../protocol/enums.dart';

import 'ops.dart';

/// obs-websocket is responding to a request batch coming from the client.
class RequestBatchResponseOp extends OpCode {
  String get requestId => data["requestId"];
  List<RequestResponseOp> get results =>
      data["results"].map((d) => RequestResponseOp(d)).toList();

  @override
  WebSocketOpCode get code => WebSocketOpCode.requestBatchResponse;

  RequestBatchResponseOp(super.data);
}
