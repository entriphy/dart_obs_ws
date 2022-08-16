import '../protocol/enums.dart';
import 'ops.dart';

/// Client is making a batch of requests for obs-websocket.
/// Requests are processed serially (in order) by the server.
class RequestBatchOp extends OpCode {
  String get requestId => data["requestId"];
  bool get haltOnFailure => data["haltOnFailure"] ?? false;
  RequestBatchExecutionType get executionType =>
      RequestBatchExecutionType.fromInt(data["executionType"] ??
          RequestBatchExecutionType.serialRealtime.value);
  List<RequestOp> get requests =>
      data["requests"].map((d) => RequestOp(d)).toList();

  @override
  WebSocketOpCode get code => WebSocketOpCode.requestBatch;

  RequestBatchOp(super.data);
  RequestBatchOp.create(
      {required String requestId,
      bool haltOnFailure = false,
      RequestBatchExecutionType executionType =
          RequestBatchExecutionType.serialRealtime,
      required List<RequestOp> requests})
      : super({
          "requestId": requestId,
          "haltOnFailure": haltOnFailure,
          "executionType": executionType.value,
          "requests": requests.map((req) => req.data).toList()
        });
}
