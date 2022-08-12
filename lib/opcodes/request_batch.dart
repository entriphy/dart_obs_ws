import '../protocol/enums.dart';
import 'opcodes.dart';

/// Client is making a batch of requests for obs-websocket. Requests are processed serially (in order) by the server.
class RequestBatchOpCode extends OpCode {
  String get requestId => data["requestId"];
  List<RequestOpCode> get requests =>
      data["requests"].map((d) => RequestOpCode(d)).toList();
  bool get haltOnFailure => data["haltOnFailure"] ?? false;
  RequestBatchExecutionType get executionType =>
      RequestBatchExecutionType.fromInt(data["executionType"] ??
          RequestBatchExecutionType.serialRealtime.value);

  @override
  WebSocketOpCode get code => WebSocketOpCode.requestBatch;

  RequestBatchOpCode(super.data);
}
