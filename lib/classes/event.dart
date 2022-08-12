import 'package:obs_ws/classes/serializable.dart';

abstract class Event extends Serializable {
  Event(super.data);
}
