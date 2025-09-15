import 'serializable.dart';

class ObsWebSocketEvent extends Serializable {
  String type;

  ObsWebSocketEvent(this.type, super.data);
}
