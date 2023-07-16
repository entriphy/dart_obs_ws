import '../protocol/enums.dart';
import 'ops.dart';

/// Client is making a batch of requests for obs-websocket.
/// Requests are processed serially (in order) by the server.
class RequestBatchOpCode extends OpCode {
  String get requestId => data["requestId"];
  bool get haltOnFailure => data["haltOnFailure"] ?? false;
  RequestBatchExecutionType get executionType =>
      RequestBatchExecutionType.fromInt(data["executionType"] ??
          RequestBatchExecutionType.serialRealtime.value);
  List<RequestOpCode> get requests =>
      data["requests"].map((d) => RequestOpCode(d)).toList();

  @override
  WebSocketOpCode get code => WebSocketOpCode.requestBatch;

  RequestBatchOpCode(super.data);
  RequestBatchOpCode.create(
      {required String requestId,
      bool haltOnFailure = false,
      RequestBatchExecutionType executionType =
          RequestBatchExecutionType.serialRealtime,
      required List<RequestOpCode> requests})
      : super({
          "requestId": requestId,
          "haltOnFailure": haltOnFailure,
          "executionType": executionType.value,
          "requests": requests.map((req) => req.data).toList()
        });
}
