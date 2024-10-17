import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
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
  int counter = 0;
  late StreamController<OpCode> _opCodeStreamController;
  late StreamController<OBSWebSocketEvent> _eventStreamController;
  Stream<OpCode> get opCodeStream => _opCodeStreamController.stream;
  Stream<OBSWebSocketEvent> get eventStream => _eventStreamController.stream;

  OBSWebSocket._(this.ws, this.msgpack) {
    counter = 0;
    _opCodeStreamController = StreamController.broadcast();
    _eventStreamController = StreamController.broadcast();
    ws.stream.asBroadcastStream().listen(_listener, onDone: disconnect);
  }

  Map<String, dynamic> _castMap(Map map) => Map<String, dynamic>.from(map);

  void _listener(dynamic data) {
    Map<String, dynamic> d = !msgpack ? json.decode(data) : json.decode(data);
    d["d"] = _castMap(d["d"]);
    WebSocketOpCode opCode = WebSocketOpCode.fromInt(d["op"]);
    OpCode op = OpCode.opCodeMap[opCode]!(d["d"]);
    if (!_opCodeStreamController.isClosed) {
      _opCodeStreamController.add(op);
      if (op is EventOpCode) {
        OBSWebSocketEvent event;
        if (eventMap.containsKey(op.eventType)) {
          event = eventMap[op.eventType]!(op.eventType, op.eventData ?? {});
        } else {
          event = OBSWebSocketEvent(op.eventType, op.eventData ?? {});
        }

        if (!_eventStreamController.isClosed) {
          _eventStreamController.add(event);
        }
      }
    }
  }

  /// Connects to obs-websocket using the given [host] and [port].
  ///
  /// If [ssl] is set to true, `wss://` will be used instead of `ws://`.
  ///
  /// See docs for [connectUri] for info about other parameters.
  static Future<OBSWebSocket> connect(String host,
      {int port = 4455,
      bool ssl = false,
      bool msgpack = false,
      bool auto = true,
      String? password,
      List<EventSubscription>? subscriptions}) {
    Uri uri = Uri.parse("ws${ssl ? 's' : ''}://$host:$port");
    return connectUri(uri,
        msgpack: msgpack,
        auto: auto,
        password: password,
        subscriptions: subscriptions);
  }

  /// Connects to obs-websocket using a [Uri].
  ///
  /// If [msgpack] is set to true, messages will be sent as binary rather than
  /// JSON. Might have a performance impact.
  /// (NOTE: this currently does not work)
  ///
  /// [password] is the password to use when authenticating to the host if
  /// [auto] is set to true. [subscriptions] is the list of event subscriptions
  /// to subscribe to if [auto] is set to true.
  ///
  /// If [auto] is set to true, the function will automatically wait for
  /// [WebSocketOpCode.hello], identify/authenticate the client by sending
  /// [WebSocketOpCode.identify], and wait for [WebSocketOpCode.identified].
  /// An [OBSWebSocketAuthException] will be thrown if [password] is
  /// `null` when the host requires a password or if [password] is incorrect.
  static Future<OBSWebSocket> connectUri(Uri uri,
      {bool msgpack = false,
      bool auto = true,
      String? password,
      List<EventSubscription>? subscriptions}) async {
    WebSocketChannel ws = WebSocketChannel.connect(uri,
        protocols: [!msgpack ? "obswebsocket.json" : "obswebsocket.msgpack"]);
    OBSWebSocket obs = OBSWebSocket._(ws, msgpack);

    if (auto) {
      HelloOpCode hello = await obs.waitForOpCode(WebSocketOpCode.hello);
      String? auth; // Authentication string (if required)
      if (hello.authentication != null) {
        // Authentication needed; create authentication string
        if (password == null) {
          throw OBSWebSocketAuthException(
              "The host requires a password, but no password was provided.");
        }
        auth = OBSWebSocket.createAuthenticationString(
          password,
          hello.authentication!.challenge,
          hello.authentication!.salt,
        );
      }

      // Get integer for event subscriptions
      int eventSubs = 0;
      if (subscriptions != null) {
        for (var sub in subscriptions) {
          eventSubs |= sub.value;
        }
      }

      // Identify and authenticate self
      obs.sendOpCode(IdentifyOpCode.create(
        rpcVersion: hello.rpcVersion,
        authentication: auth,
        eventSubscriptions: eventSubs,
      ));

      try {
        await obs.waitForOpCode(WebSocketOpCode.identified);
      } catch (e) {
        if (obs.closeCode == WebSocketCloseCode.authenticationFailed) {
          throw OBSWebSocketAuthException("The password provided is incorrect");
        } else {
          rethrow; // Most likely not an obs-websocket related error
        }
      }
    }

    return obs;
  }

  /// Disconnects from obs-websocket and closes all event streams.
  Future<void> disconnect() async {
    await _opCodeStreamController.close();
    await _eventStreamController.close();
    await ws.sink.close();
  }

  /// Waits for an opcode from the host and returns it once received.
  Future<T> waitForOpCode<T extends OpCode>(WebSocketOpCode code,
      [int timeout = 15]) async {
    return (await opCodeStream
        .firstWhere((opcode) => opcode.code == code)
        .timeout(Duration(seconds: timeout))) as T;
  }

  /// Sends an opcode to the host.
  void sendOpCode(OpCode op) {
    Map<String, dynamic> data = {"op": op.code.value, "d": op.data};
    if (msgpack) {
      ws.sink.add(jsonEncode(data));
    } else {
      ws.sink.add(jsonEncode(data));
    }
  }

  /// Calls a request and returns the response.
  Future<OBSWebSocketResponse> call(String requestType,
      [Map<String, dynamic>? requestData]) async {
    // Prepare request
    String requestId = (counter++).toString(); // Generate ID for request
    RequestOpCode request = RequestOpCode.create(
      requestType: requestType,
      requestId: requestId,
      requestData: requestData,
    ); // Create request op
    sendOpCode(request); // Send request op

    // Wait for response with matching ID
    RequestResponseOpCode responseOp = await opCodeStream
        .firstWhere((op) =>
            op.code == WebSocketOpCode.requestResponse &&
            (op as RequestResponseOpCode).requestId == requestId)
        .timeout(Duration(seconds: requestTimeout)) as RequestResponseOpCode;

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

  /// Sends a request to the host using an [OBSWebSocketRequest] object.
  ///
  /// The type parameter is the response wrapper class to use when returning
  /// the response.
  Future<T> sendRequest<T extends OBSWebSocketResponse>(
      OBSWebSocketRequest request) async {
    // Prepare request
    String requestId = (counter++).toString(); // Generate ID for request
    RequestOpCode requestOp = RequestOpCode.create(
      requestType: request.type,
      requestId: requestId,
      requestData: request.data,
    ); // Create request op
    sendOpCode(requestOp); // Send request op

    // Wait for response with matching ID
    RequestResponseOpCode responseOp = await opCodeStream
        .firstWhere((op) =>
            op.code == WebSocketOpCode.requestResponse &&
            (op as RequestResponseOpCode).requestId == requestId)
        .timeout(Duration(seconds: requestTimeout)) as RequestResponseOpCode;

    // Throw exception if result is false
    if (!responseOp.requestStatus.result) {
      var error = OBSWebSocketRequestException(responseOp.requestStatus);
      _eventStreamController.addError(error);
      if (throwOnRequestError) throw error;
    }

    // Return as generic response
    T response = request.serializeResponse(
      responseOp.responseData ?? Map<String, dynamic>.from({}),
      responseOp.requestStatus,
    ) as T;
    request.response = response;
    return response;
  }

  /// Sends a batch of requests to the host.
  ///
  /// [haltOnFailure] and [executionType] determines the behaviour of the way
  /// the requests are executed as specified in the obs-websocket protocol.
  ///
  /// If [serializeResults] is set to true, each response will be mapped and
  /// [OBSWebSocketRequest.response] will get set for each request specified
  /// in the [requests] list.
  Future<List<OBSWebSocketResponse>> sendBatchRequest(
    Iterable<OBSWebSocketRequest> requests, {
    bool haltOnFailure = false,
    RequestBatchExecutionType executionType =
        RequestBatchExecutionType.serialRealtime,
    bool serializeResults = true,
  }) async {
    assert(requests.isNotEmpty);

    // Prepare requests
    Map<String, OBSWebSocketRequest> requestIds = {};
    List<RequestOpCode> requestOpCodes = [];
    for (OBSWebSocketRequest req in requests) {
      String requestId = (counter++).toString(); // Generate ID for request
      requestOpCodes.add(RequestOpCode.create(
        requestType: req.type,
        requestId: requestId,
        requestData: req.data,
      ));
      requestIds[requestId] = req;
    }

    // Send batch request
    String requestId = (counter++).toString(); // Generate ID for request
    RequestBatchOpCode batchRequest = RequestBatchOpCode.create(
      requestId: requestId,
      haltOnFailure: haltOnFailure,
      executionType: executionType,
      requests: requestOpCodes,
    ); // Create batch request op
    sendOpCode(batchRequest); // Send the request op

    // Wait for response with matching ID
    RequestBatchResponseOpCode responseOp = await opCodeStream
            .firstWhere((op) =>
                op.code == WebSocketOpCode.requestBatchResponse &&
                (op as RequestBatchResponseOpCode).requestId == requestId)
            .timeout(Duration(seconds: requestTimeout))
        as RequestBatchResponseOpCode;

    // Serialize results
    if (serializeResults) {
      for (var res in responseOp.results) {
        OBSWebSocketRequest? req = requestIds[res.requestId];
        if (req != null) {
          req.response = req.serializeResponse(
              res.responseData ?? Map<String, dynamic>.from({}),
              res.requestStatus);
        }
      }
    }

    // Return responses
    return responseOp.results
        .map<OBSWebSocketResponse>((res) =>
            OBSWebSocketResponse(res.responseData ?? {}, res.requestStatus))
        .toList();
  }

  /// Creates the authentication string given a password and the challenge/salt
  /// from a [HelloOpCode].
  ///
  /// Mainly for use with [IdentifyOpCode.authentication].
  static String createAuthenticationString(
      String password, String challenge, String salt) {
    // Concatenate the websocket password with the salt provided by the server
    // (password + salt)
    String concat = password + salt;

    // Generate an SHA256 binary hash of the result and base64 encode it,
    // known as a base64 secret.
    String secret = base64.encode(sha256.convert(utf8.encode(concat)).bytes);

    // Concatenate the base64 secret with the challenge sent by the server
    // (base64_secret + challenge)
    concat = secret + challenge;

    // Generate a binary SHA256 hash of that result and base64 encode it.
    // You now have your authentication string.
    String authentication =
        base64.encode(sha256.convert(utf8.encode(concat)).bytes);

    return authentication;
  }
}

class OBSWebSocketAuthException {
  String error;

  OBSWebSocketAuthException(this.error);

  @override
  String toString() => "The password provided is incorrect";
}

class OBSWebSocketRequestException {
  RequestResponseStatus status;

  OBSWebSocketRequestException(this.status);

  @override
  String toString() => "${status.code}: ${status.comment}";
}
