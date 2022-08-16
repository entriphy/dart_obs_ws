import 'serializable.dart';

abstract class OBSWebSocketEvent extends Serializable {
  OBSWebSocketEvent(super.data);
}
