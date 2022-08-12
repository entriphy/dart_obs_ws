import 'package:obs_ws/classes/serializable.dart';

abstract class OBSWebSocketEvent extends Serializable {
  OBSWebSocketEvent(super.data);
}
