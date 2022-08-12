import 'serializable.dart';

class OBSWebSocketRequest extends Serializable {
  final String type;

  OBSWebSocketRequest(this.type, [Map<String, dynamic>? data])
      : super(data ?? {});
}
