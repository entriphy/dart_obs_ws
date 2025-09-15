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

class ObsWebSocket {
  // WebSocket
  final WebSocketChannel _ws;
  ObsWebSocketCloseCode? get closeCode => _ws.closeCode != null
      ? ObsWebSocketCloseCode.fromInt(_ws.closeCode!)
      : null;
  String? get closeReason => _ws.closeReason;

  // Settings
  int requestTimeout = 15;
  bool throwOnRequestError = false;
  final bool msgpack;

  // Streams and stuff
  int _counter = 0;
  late StreamController<ObsOp> _opStreamController;
  late StreamController<ObsWebSocketEvent> _eventStreamController;
  Stream<ObsOp> get opStream => _opStreamController.stream;
  Stream<ObsWebSocketEvent> get eventStream => _eventStreamController.stream;

  ObsWebSocket._(this._ws, this.msgpack) {
    _counter = 0;
    _opStreamController = StreamController.broadcast();
    _eventStreamController = StreamController.broadcast();
    _ws.stream.asBroadcastStream().listen(_listener, onDone: disconnect);
  }

  Map<String, dynamic> _castMap(Map map) => Map<String, dynamic>.from(map);

  void _listener(dynamic data) {
    Map<String, dynamic> d = !msgpack ? json.decode(data) : json.decode(data);
    d["d"] = _castMap(d["d"]);
    final opCode = ObsWebSocketOpCode.fromInt(d["op"]);
    final op = ObsOp.opCodeMap[opCode]!(d["d"]);
    if (!_opStreamController.isClosed) {
      _opStreamController.add(op);
      if (op is ObsEventOp) {
        final data = op.eventData ?? {};
        final event = eventMap.containsKey(op.eventType)
            ? eventMap[op.eventType]!(op.eventType, data)
            : ObsWebSocketEvent(op.eventType, data);

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
  static Future<ObsWebSocket> connect(String host,
      {int port = 4455,
      bool ssl = false,
      bool msgpack = false,
      bool auto = true,
      String? password,
      Iterable<ObsEventSubscription>? subscriptions}) {
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
  /// [ObsWebSocketOpCode.hello], identify/authenticate the client by sending
  /// [ObsWebSocketOpCode.identify], and wait for [ObsWebSocketOpCode.identified].
  /// An [ObsWebSocketAuthException] will be thrown if [password] is
  /// `null` when the host requires a password or if [password] is incorrect.
  static Future<ObsWebSocket> connectUri(Uri uri,
      {bool msgpack = false,
      bool auto = true,
      String? password,
      Iterable<ObsEventSubscription>? subscriptions}) async {
    final ws = WebSocketChannel.connect(uri,
        protocols: [!msgpack ? "obswebsocket.json" : "obswebsocket.msgpack"]);
    final obs = ObsWebSocket._(ws, msgpack);

    if (auto) {
      final ObsHelloOp hello =
          await obs.waitForOpCode(ObsWebSocketOpCode.hello);
      String? auth; // Authentication string (if required)
      if (hello.authentication != null) {
        // Authentication needed; create authentication string
        if (password == null) {
          throw ObsWebSocketAuthException(
              ObsWebSocketAuthExceptionType.passwordMissing);
        }
        auth = ObsWebSocket.createAuthenticationString(
          password,
          hello.authentication!.challenge,
          hello.authentication!.salt,
        );
      }

      // Get integer for event subscriptions
      final eventSubs =
          subscriptions?.fold<int>(0, (prev, sub) => prev | sub.value) ?? 0;

      // Identify and authenticate self
      final identify = ObsIdentifyOp.create(
        rpcVersion: hello.rpcVersion,
        authentication: auth,
        eventSubscriptions: eventSubs,
      );
      obs.sendOp(identify);

      try {
        await obs.waitForOpCode(ObsWebSocketOpCode.identified);
      } catch (e) {
        if (obs.closeCode == ObsWebSocketCloseCode.authenticationFailed) {
          throw ObsWebSocketAuthException(
              ObsWebSocketAuthExceptionType.passwordIncorrect);
        } else {
          rethrow; // Most likely not an obs-websocket related error
        }
      }
    }

    return obs;
  }

  /// Closes all event streams and disconnects from obs-websocket.
  Future<void> disconnect() async {
    await _opStreamController.close();
    await _eventStreamController.close();
    await _ws.sink.close();
  }

  /// Waits for an opcode from the host and returns it once received.
  Future<T> waitForOpCode<T extends ObsOp>(ObsWebSocketOpCode code,
      {int timeout = 15}) async {
    return (await opStream
        .firstWhere((opcode) => opcode.code == code)
        .timeout(Duration(seconds: timeout))) as T;
  }

  /// Sends an opcode to the host.
  void sendOp(ObsOp op) {
    Map<String, dynamic> data = {"op": op.code.value, "d": op.data};
    if (msgpack) {
      _ws.sink.add(jsonEncode(data));
    } else {
      _ws.sink.add(jsonEncode(data));
    }
  }

  /// Calls a request and returns the response.
  Future<ObsWebSocketResponse> call(String requestType,
      [Map<String, dynamic>? requestData]) async {
    // Prepare request
    final requestId = (_counter++).toString(); // Generate ID for request
    final request = ObsRequestOp.create(
      requestType: requestType,
      requestId: requestId,
      requestData: requestData,
    ); // Create request op
    sendOp(request); // Send request op

    // Wait for response with matching ID
    final responseOp = await opStream
        .firstWhere((op) =>
            op.code == ObsWebSocketOpCode.requestResponse &&
            (op as ObsRequestResponseOp).requestId == requestId)
        .timeout(Duration(seconds: requestTimeout)) as ObsRequestResponseOp;

    // Throw exception if result is false
    if (!responseOp.requestStatus.result) {
      final error = ObsWebSocketRequestException(responseOp.requestStatus);
      _eventStreamController.addError(error);
      if (throwOnRequestError) throw error;
    }

    // Return as generic response
    return ObsWebSocketResponse(
        responseOp.responseData ?? {}, responseOp.requestStatus);
  }

  /// Sends a request to the host using an [ObsWebSocketRequest] object.
  ///
  /// The type parameter is the response wrapper class to use when returning
  /// the response.
  Future<T> sendRequest<T extends ObsWebSocketResponse>(
      ObsWebSocketRequest request) async {
    // Prepare request
    final requestId = (_counter++).toString(); // Generate ID for request
    final requestOp = ObsRequestOp.create(
      requestType: request.type,
      requestId: requestId,
      requestData: request.data,
    ); // Create request op
    sendOp(requestOp); // Send request op

    // Wait for response with matching ID
    final responseOp = await opStream
        .firstWhere((op) =>
            op.code == ObsWebSocketOpCode.requestResponse &&
            (op as ObsRequestResponseOp).requestId == requestId)
        .timeout(Duration(seconds: requestTimeout)) as ObsRequestResponseOp;

    // Throw exception if result is false
    if (!responseOp.requestStatus.result) {
      final error = ObsWebSocketRequestException(responseOp.requestStatus);
      _eventStreamController.addError(error);
      if (throwOnRequestError) throw error;
    }

    // Return as generic response
    T response = request.serializeResponse(
      responseOp.responseData ?? <String, dynamic>{},
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
  /// [ObsWebSocketRequest.response] will get set for each request specified
  /// in the [requests] list.
  Future<List<ObsWebSocketResponse>> sendBatchRequest(
    Iterable<ObsWebSocketRequest> requests, {
    bool haltOnFailure = false,
    ObsRequestBatchExecutionType executionType =
        ObsRequestBatchExecutionType.serialRealtime,
    bool serializeResults = true,
  }) async {
    assert(requests.isNotEmpty);

    // Prepare requests
    Map<String, ObsWebSocketRequest> requestIds = {};
    List<ObsRequestOp> requestOpCodes = [];
    for (ObsWebSocketRequest req in requests) {
      String requestId = (_counter++).toString(); // Generate ID for request
      requestOpCodes.add(ObsRequestOp.create(
        requestType: req.type,
        requestId: requestId,
        requestData: req.data,
      ));
      requestIds[requestId] = req;
    }

    // Send batch request
    String requestId = (_counter++).toString(); // Generate ID for request
    ObsRequestBatchOp batchRequest = ObsRequestBatchOp.create(
      requestId: requestId,
      haltOnFailure: haltOnFailure,
      executionType: executionType,
      requests: requestOpCodes,
    ); // Create batch request op
    sendOp(batchRequest); // Send the request op

    // Wait for response with matching ID
    ObsRequestBatchResponseOp responseOp = await opStream
            .firstWhere((op) =>
                op.code == ObsWebSocketOpCode.requestBatchResponse &&
                (op as ObsRequestBatchResponseOp).requestId == requestId)
            .timeout(Duration(seconds: requestTimeout))
        as ObsRequestBatchResponseOp;

    // Serialize results
    if (serializeResults) {
      for (var res in responseOp.results) {
        ObsWebSocketRequest? req = requestIds[res.requestId];
        if (req != null) {
          req.response = req.serializeResponse(
              res.responseData ?? Map<String, dynamic>.from({}),
              res.requestStatus);
        }
      }
    }

    // Return responses
    return responseOp.results
        .map<ObsWebSocketResponse>((res) =>
            ObsWebSocketResponse(res.responseData ?? {}, res.requestStatus))
        .toList();
  }

  /// Reidentifies the client with the server, updating event subscriptions
  /// from [subscriptions].
  Future<void> reidentify(
      {Iterable<ObsEventSubscription>? subscriptions}) async {
    final eventSubs =
        subscriptions?.fold<int>(0, (prev, sub) => prev | sub.value) ?? 0;

    final reidentifyOp = ObsReidentifyOp.create(eventSubs);
    sendOp(reidentifyOp);
    await waitForOpCode(ObsWebSocketOpCode.identified);
  }

  /// Creates the authentication string given a password and the challenge/salt
  /// from a [ObsHelloOp].
  ///
  /// Mainly for use with [ObsIdentifyOp.authentication].
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

enum ObsWebSocketAuthExceptionType { passwordMissing, passwordIncorrect }

class ObsWebSocketAuthException {
  final ObsWebSocketAuthExceptionType type;

  const ObsWebSocketAuthException(this.type);

  @override
  String toString() => type.toString();
}

class ObsWebSocketRequestException {
  final ObsRequestResponseStatus status;

  const ObsWebSocketRequestException(this.status);

  @override
  String toString() => "${status.code}: ${status.comment}";
}
