import '../protocol/enums.dart';

import 'ops.dart';

/// An event coming from OBS has occured. Eg scene switched, source muted.
class ObsEventOp extends ObsOp {
  String get eventType => data["eventType"];
  int get eventIntent => data["eventIntent"];
  Map<String, dynamic>? get eventData => data["eventData"];

  @override
  ObsWebSocketOpCode get code => ObsWebSocketOpCode.event;

  ObsEventOp(super.data);
}
