import '../protocol/enums.dart';

import 'ops.dart';

/// obs-websocket is responding to a request batch coming from the client.
class ObsRequestBatchResponseOp extends ObsOp {
  String get requestId => data["requestId"];
  List<ObsRequestResponseOp> get results => data["results"]
      .map<ObsRequestResponseOp>((d) => ObsRequestResponseOp(d))
      .toList();

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.requestBatchResponse;

  ObsRequestBatchResponseOp(super.data);
}
