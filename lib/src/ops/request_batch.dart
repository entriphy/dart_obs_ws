import '../protocol/enums.dart';
import 'ops.dart';

/// Client is making a batch of requests for obs-websocket.
/// Requests are processed serially (in order) by the server.
class ObsRequestBatchOp extends ObsOp {
  String get requestId => data["requestId"];
  bool get haltOnFailure => data["haltOnFailure"] ?? false;
  ObsRequestBatchExecutionType get executionType =>
      ObsRequestBatchExecutionType.fromInt(data["executionType"] ??
          ObsRequestBatchExecutionType.serialRealtime.value);
  List<ObsRequestOp> get requests =>
      data["requests"].map((d) => ObsRequestOp(d)).toList();

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.requestBatch;

  ObsRequestBatchOp(super.data);
  ObsRequestBatchOp.create(
      {required String requestId,
      bool haltOnFailure = false,
      ObsRequestBatchExecutionType executionType =
          ObsRequestBatchExecutionType.serialRealtime,
      required List<ObsRequestOp> requests})
      : super({
          "requestId": requestId,
          "haltOnFailure": haltOnFailure,
          "executionType": executionType.value,
          "requests": requests.map((req) => req.data).toList()
        });
}
