import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'protocol/protocol.dart';
import 'ops/ops.dart';
import 'classes/event.dart';
import 'classes/request.dart';
import 'classes/response.dart';

export 'protocol/protocol.dart';
export 'classes/request.dart';
export 'classes/response.dart';
export 'classes/event.dart';
export 'ops/ops.dart';

class OBSWebSocket {
  // WebSocket
  final WebSocketChannel ws;
  WebSocketCloseCode? get closeCode =>
      ws.closeCode != null ? WebSocketCloseCode.fromInt(ws.closeCode!) : null;
  String? get closeReason => ws.closeReason;

  // Settings
  int requestTimeout = 15;
  bool throwOnRequestError = false;
  final bool msgpack;

  // Streams and stuff
  late Uuid _uuid;
  late StreamController<OpCode> _opStreamController;
  late StreamController<OBSWebSocketEvent> _eventStreamController;
  Stream<OpCode> get opStream => _opStreamController.stream;
  Stream<OBSWebSocketEvent> get eventStream => _eventStreamController.stream;

  OBSWebSocket._(this.ws, this.msgpack) {
    _uuid = Uuid();
    _opStreamController = StreamController.broadcast();
    _eventStreamController = StreamController.broadcast();
    ws.stream.asBroadcastStream().listen(_listener, onDone: disconnect);
  }

  Map<String, dynamic> _castMap(Map map) => Map<String, dynamic>.from(map);

  void _listener(dynamic data) {
    Map<String, dynamic> d = !msgpack ? json.decode(data) : json.decode(data);
    d["d"] = _castMap(d["d"]);
    WebSocketOpCode opCode = WebSocketOpCode.fromInt(d["op"]);
    OpCode op = OpCode.OpCodeMap[opCode]!(d["d"]);
    _opStreamController.add(op);
    if (op is EventOp) {
      OBSWebSocketEvent event = EventMap[op.eventType]!(op.eventData ?? {});
      _eventStreamController.add(event);
    }
  }

  static Future<OBSWebSocket> connect(String host,
      {int port = 4455, bool ssl = false, bool msgpack = false}) {
    Uri uri = Uri.parse("ws${ssl ? 's' : ''}://$host:$port");
    return connectUri(uri, msgpack: msgpack);
  }

  static Future<OBSWebSocket> connectUri(Uri uri,
      {bool msgpack = false}) async {
    WebSocketChannel ws = WebSocketChannel.connect(uri,
        protocols: [!msgpack ? "obswebsocket.json" : "obswebsocket.msgpack"]);
    OBSWebSocket obs = OBSWebSocket._(ws, msgpack);
    return obs;
  }

  Future<void> disconnect() async {
    await _opStreamController.close();
    await _eventStreamController.close();
    await ws.sink.close();
  }

  Future<T> waitForOpCode<T extends OpCode>(WebSocketOpCode code,
      [int timeout = 15]) async {
    return (await opStream
        .firstWhere((opcode) => opcode.code == code)
        .timeout(Duration(seconds: timeout))) as T;
  }

  void sendOpCode(OpCode op) {
    Map<String, dynamic> data = {"op": op.code.value, "d": op.data};
    if (msgpack) {
      ws.sink.add(jsonEncode(data));
    } else {
      ws.sink.add(jsonEncode(data));
    }
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
    if (!responseOp.requestStatus.result) {
      var error = OBSWebSocketRequestException(responseOp.requestStatus);
      _eventStreamController.addError(error);
      if (throwOnRequestError) throw error;
    }

    // Return as generic response
    return OBSWebSocketResponse(
        responseOp.responseData ?? {}, responseOp.requestStatus);
  }

  Future<T> sendRequest<T extends OBSWebSocketResponse>(
      OBSWebSocketRequest request) async {
    // Prepare request
    String requestId = _uuid.v4(); // Generate ID for request
    RequestOp requestOp = RequestOp.create(
      requestType: request.type,
      requestId: requestId,
      requestData: request.data,
    ); // Create request op
    sendOpCode(requestOp); // Send request op

    // Wait for response with matching ID
    RequestResponseOp responseOp = await opStream
        .firstWhere((op) =>
            op.code == WebSocketOpCode.requestResponse &&
            (op as RequestResponseOp).requestId == requestId)
        .timeout(Duration(seconds: requestTimeout)) as RequestResponseOp;

    // Throw exception if result is false
    if (!responseOp.requestStatus.result) {
      var error = OBSWebSocketRequestException(responseOp.requestStatus);
      _eventStreamController.addError(error);
      if (throwOnRequestError) throw error;
    }

    // Return as generic response
    T response = request.serializeResponse(
        responseOp.responseData ?? {}, responseOp.requestStatus) as T;
    request.response = response;
    return response;
  }

  Future<List<OBSWebSocketResponse>> callBatch(
      List<OBSWebSocketRequest> requests,
      {bool haltOnFailure = false,
      RequestBatchExecutionType executionType =
          RequestBatchExecutionType.serialRealtime}) async {
    // Prepare request
    assert(requests.isNotEmpty);
    String requestId = _uuid.v4(); // Generate ID for request
    List<RequestOp> requestOpCodes = requests
        .map((req) => RequestOp.create(
              requestType: req.type,
              requestId: requestId,
              requestData: req.data,
            ))
        .toList(); // Create request ops
    RequestBatchOp batchRequest = RequestBatchOp.create(
      requestId: requestId,
      haltOnFailure: haltOnFailure,
      executionType: executionType,
      requests: requestOpCodes,
    ); // Create batch request op
    sendOpCode(batchRequest); // Send the request op

    // Wait for response with matching ID
    RequestBatchResponseOp responseOp = await opStream
        .firstWhere((op) =>
            op.code == WebSocketOpCode.requestBatchResponse &&
            (op as RequestBatchResponseOp).requestId == requestId)
        .timeout(Duration(seconds: requestTimeout)) as RequestBatchResponseOp;

    // Return
    return responseOp.results
        .map<OBSWebSocketResponse>((res) =>
            OBSWebSocketResponse(res.responseData ?? {}, res.requestStatus))
        .toList();
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
