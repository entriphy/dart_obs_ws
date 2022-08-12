library obs_ws;

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:obs_ws/classes/event.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'classes/request.dart';
import 'classes/response.dart';
import 'ops/ops.dart';
import 'protocol/protocol.dart';

export 'ops/ops.dart';
export 'protocol/protocol.dart';

class OBSWebSocket {
  // WebSocket
  final WebSocketChannel _ws;
  WebSocketChannel get ws => _ws;
  WebSocketCloseCode? get closeCode =>
      ws.closeCode != null ? WebSocketCloseCode.fromInt(ws.closeCode!) : null;
  String? get closeReason => ws.closeReason;

  // Settings
  int requestTimeout = 15;
  bool throwOnRequestError = false;

  // Streams and stuff
  late Uuid _uuid;
  late StreamController<OpCode> _opStreamController;
  late StreamController<Event> _eventStreamController;
  Stream<OpCode> get opStream => _opStreamController.stream;
  Stream<Event> get eventStream => _eventStreamController.stream;

  OBSWebSocket._(this._ws) {
    _uuid = Uuid();
    _opStreamController = StreamController.broadcast();
    _eventStreamController = StreamController.broadcast();
    _ws.stream.asBroadcastStream().listen(_listener);
  }

  void _listener(dynamic data) {
    Map<String, dynamic> d = json.decode(data);
    OpCode op = OpCode.OpCodeMap[WebSocketOpCode.fromInt(d["op"])]!(d["d"]);
    _opStreamController.add(op);
    if (op is EventOp) {
      Event event = EventMap[op.eventType]!(op.eventData ?? {});
      _eventStreamController.add(event);
    }
  }

  static Future<OBSWebSocket> connect(String host,
      {int port = 4455, bool ssl = false}) {
    Uri uri = Uri.parse("ws${ssl ? 's' : ''}://$host:$port");
    return connectUri(uri);
  }

  static Future<OBSWebSocket> connectUri(Uri uri) async {
    WebSocketChannel ws =
        WebSocketChannel.connect(uri, protocols: ["obswebsocket.json"]);
    OBSWebSocket obs = OBSWebSocket._(ws);
    return obs;
  }

  Future<void> disconnect() async {
    await ws.sink.close();
  }

  Future<T> waitForOpCode<T extends OpCode>(WebSocketOpCode code,
      [int timeout = 15]) async {
    return (await opStream
        .firstWhere((opcode) => opcode.code == code)
        .timeout(Duration(seconds: timeout))) as T;
  }

  void sendOpCode(OpCode op) {
    ws.sink.add(jsonEncode({"op": op.code.value, "d": op.data}));
  }

  Future<OBSWebSocketResponse> call(String requestType,
      [Map<String, dynamic>? requestData]) async {
    // Prepare request
    String requestId = _uuid.v4(); // Generate ID for request
    RequestOp request = RequestOp.create(
      requestType: requestType,
      requestId: requestId,
      requestData: requestData,
    ); // Create request op
    sendOpCode(request); // Send request op

    // Wait for response with matching ID
    RequestResponseOp responseOp = await opStream
        .firstWhere((op) =>
            op.code == WebSocketOpCode.requestResponse &&
            (op as RequestResponseOp).requestId == requestId)
        .timeout(Duration(seconds: requestTimeout)) as RequestResponseOp;

    // Throw exception if result is false
    if (throwOnRequestError && !responseOp.requestStatus.result) {
      throw OBSWebSocketRequestException(responseOp.requestStatus);
    }

    // Return as generic response
    return OBSWebSocketResponse(
        responseOp.responseData ?? {}, responseOp.requestStatus);
  }

  static String createAuthenticationString(
      String password, String challenge, String salt) {
    // Concatenate the websocket password with the salt provided by the server (password + salt)
    String concat = password + salt;
    // Generate an SHA256 binary hash of the result and base64 encode it, known as a base64 secret.
    String secret = base64.encode(sha256.convert(utf8.encode(concat)).bytes);
    // Concatenate the base64 secret with the challenge sent by the server (base64_secret + challenge)
    concat = secret + challenge;
    // Generate a binary SHA256 hash of that result and base64 encode it. You now have your authentication string.
    String authentication =
        base64.encode(sha256.convert(utf8.encode(concat)).bytes);

    return authentication;
  }
}

class OBSWebSocketRequestException {
  RequestResponseStatus status;

  OBSWebSocketRequestException(this.status);

  @override
  String toString() => "${status.code}: ${status.comment}";
}
