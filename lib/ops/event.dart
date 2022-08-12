import '../protocol/enums.dart';

import 'ops.dart';

/// An event coming from OBS has occured. Eg scene switched, source muted.
class EventOp extends OpCode {
  String get eventType => data["eventType"];
  int get eventIntent => data["eventIntent"];
  Map<String, dynamic>? get eventData => data["eventData"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.event;

  EventOp(super.data);
}
