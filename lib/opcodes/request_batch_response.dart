import '../protocol/enums.dart';

import 'opcodes.dart';

/// obs-websocket is responding to a request batch coming from the client.
class RequestBatchResponseOpCode extends OpCode {
  String get requestId => data["requestId"];
  List<RequestResponseOpCode> get results =>
      data["results"].map((d) => RequestResponseOpCode(d)).toList();

  @override
  WebSocketOpCode get code => WebSocketOpCode.requestBatchResponse;

  RequestBatchResponseOpCode(super.data);
}
