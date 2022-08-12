import '../protocol/enums.dart';

import 'opcodes.dart';

/// An event coming from OBS has occured. Eg scene switched, source muted.
class EventOpCode extends OpCode {
  String get eventType => data["eventType"];
  int get eventIntent => data["eventIntent"];
  Map<String, dynamic>? get eventData => data["eventData"];

  @override
  WebSocketOpCode get code => WebSocketOpCode.event;

  EventOpCode(super.data);
}
