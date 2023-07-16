import 'serializable.dart';

class OBSWebSocketEvent extends Serializable {
  String type;

  OBSWebSocketEvent(this.type, super.data);
}
