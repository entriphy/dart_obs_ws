enum EventSubscription {
  /// Subcription value used to disable all events.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  none(0),

  /// Subscription value to receive events in the `General` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  general(1 << 0),

  /// Subscription value to receive events in the `Config` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  config(1 << 1),

  /// Subscription value to receive events in the `Scenes` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  scenes(1 << 2),

  /// Subscription value to receive events in the `Inputs` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  inputs(1 << 3),

  /// Subscription value to receive events in the `Transitions` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  transitions(1 << 4),

  /// Subscription value to receive events in the `Filters` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  filters(1 << 5),

  /// Subscription value to receive events in the `Outputs` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  outputs(1 << 6),

  /// Subscription value to receive events in the `SceneItems` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  sceneItems(1 << 7),

  /// Subscription value to receive events in the `MediaInputs` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  mediaInputs(1 << 8),

  /// Subscription value to receive the `VendorEvent` event.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  vendors(1 << 9),

  /// Subscription value to receive events in the `Ui` category.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  ui(1 << 10),

  /// Helper to receive all non-high-volume events.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  all((1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4) | (1 << 5) | (1 << 6) | (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10)),

  /// Subscription value to receive the `InputVolumeMeters` high-volume event.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  inputVolumeMeters(1 << 16),

  /// Subscription value to receive the `InputActiveStateChanged` high-volume event.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  inputActiveStateChanged(1 << 17),

  /// Subscription value to receive the `InputShowStateChanged` high-volume event.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  inputShowStateChanged(1 << 18),

  /// Subscription value to receive the `SceneItemTransformChanged` high-volume event.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  sceneItemTransformChanged(1 << 19);

  final int value;
  const EventSubscription(this.value);
  static EventSubscription fromInt(int n) => EventSubscription.values.firstWhere((val) => val.value == n);
}

enum RequestBatchExecutionType {
  /// Not a request batch.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  none(-1),

  /// A request batch which processes all requests serially, as fast as possible.
  /// 
  /// Note: To introduce artificial delay, use the `Sleep` request and the `sleepMillis` request field.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  serialRealtime(0),

  /// A request batch type which processes all requests serially, in sync with the graphics thread. Designed to provide high accuracy for animations.
  /// 
  /// Note: To introduce artificial delay, use the `Sleep` request and the `sleepFrames` request field.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  serialFrame(1),

  /// A request batch type which processes all requests using all available threads in the thread pool.
  /// 
  /// Note: This is mainly experimental, and only really shows its colors during requests which require lots of
  /// active processing, like `GetSourceScreenshot`.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  parallel(2);

  final int value;
  const RequestBatchExecutionType(this.value);
  static RequestBatchExecutionType fromInt(int n) => RequestBatchExecutionType.values.firstWhere((val) => val.value == n);
}

enum RequestStatus {
  /// Unknown status, should never be used.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  unknown(0),

  /// For internal use to signify a successful field check.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  noError(10),

  /// The request has succeeded.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  success(100),

  /// The `requestType` field is missing from the request data.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  missingRequestType(203),

  /// The request type is invalid or does not exist.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  unknownRequestType(204),

  /// Generic error code.
  /// 
  /// Note: A comment is required to be provided by obs-websocket.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  genericError(205),

  /// The request batch execution type is not supported.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  unsupportedRequestBatchExecutionType(206),

  /// A required request field is missing.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  missingRequestField(300),

  /// The request does not have a valid requestData object.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  missingRequestData(301),

  /// Generic invalid request field message.
  /// 
  /// Note: A comment is required to be provided by obs-websocket.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidRequestField(400),

  /// A request field has the wrong data type.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidRequestFieldType(401),

  /// A request field (number) is outside of the allowed range.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  requestFieldOutOfRange(402),

  /// A request field (string or array) is empty and cannot be.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  requestFieldEmpty(403),

  /// There are too many request fields (eg. a request takes two optionals, where only one is allowed at a time).
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  tooManyRequestFields(404),

  /// An output is running and cannot be in order to perform the request.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  outputRunning(500),

  /// An output is not running and should be.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  outputNotRunning(501),

  /// An output is paused and should not be.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  outputPaused(502),

  /// An output is not paused and should be.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  outputNotPaused(503),

  /// An output is disabled and should not be.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  outputDisabled(504),

  /// Studio mode is active and cannot be.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  studioModeActive(505),

  /// Studio mode is not active and should be.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  studioModeNotActive(506),

  /// The resource was not found.
  /// 
  /// Note: Resources are any kind of object in obs-websocket, like inputs, profiles, outputs, etc.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  resourceNotFound(600),

  /// The resource already exists.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  resourceAlreadyExists(601),

  /// The type of resource found is invalid.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidResourceType(602),

  /// There are not enough instances of the resource in order to perform the request.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  notEnoughResources(603),

  /// The state of the resource is invalid. For example, if the resource is blocked from being accessed.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidResourceState(604),

  /// The specified input (obs_source_t-OBS_SOURCE_TYPE_INPUT) had the wrong kind.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidInputKind(605),

  /// The resource does not support being configured.
  /// 
  /// This is particularly relevant to transitions, where they do not always have changeable settings.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  resourceNotConfigurable(606),

  /// The specified filter (obs_source_t-OBS_SOURCE_TYPE_FILTER) had the wrong kind.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidFilterKind(607),

  /// Creating the resource failed.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  resourceCreationFailed(700),

  /// Performing an action on the resource failed.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  resourceActionFailed(701),

  /// Processing the request failed unexpectedly.
  /// 
  /// Note: A comment is required to be provided by obs-websocket.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  requestProcessingFailed(702),

  /// The combination of request fields cannot be used to perform an action.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  cannotAct(703);

  final int value;
  const RequestStatus(this.value);
  static RequestStatus fromInt(int n) => RequestStatus.values.firstWhere((val) => val.value == n);
}

enum WebSocketCloseCode {
  /// For internal use only to tell the request handler not to perform any close action.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  dontClose(0),

  /// Unknown reason, should never be used.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  unknownReason(4000),

  /// The server was unable to decode the incoming websocket message.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  messageDecodeError(4002),

  /// A data field is required but missing from the payload.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  missingDataField(4003),

  /// A data field's value type is invalid.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidDataFieldType(4004),

  /// A data field's value is invalid.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  invalidDataFieldValue(4005),

  /// The specified `op` was invalid or missing.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  unknownOpCode(4006),

  /// The client sent a websocket message without first sending `Identify` message.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  notIdentified(4007),

  /// The client sent an `Identify` message while already identified.
  /// 
  /// Note: Once a client has identified, only `Reidentify` may be used to change session parameters.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  alreadyIdentified(4008),

  /// The authentication attempt (via `Identify`) failed.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  authenticationFailed(4009),

  /// The server detected the usage of an old version of the obs-websocket RPC protocol.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  unsupportedRpcVersion(4010),

  /// The websocket session has been invalidated by the obs-websocket server.
  /// 
  /// Note: This is the code used by the `Kick` button in the UI Session List. If you receive this code, you must not automatically reconnect.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  sessionInvalidated(4011),

  /// A requested feature is not supported due to hardware/software limitations.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  unsupportedFeature(4012);

  final int value;
  const WebSocketCloseCode(this.value);
  static WebSocketCloseCode fromInt(int n) => WebSocketCloseCode.values.firstWhere((val) => val.value == n);
}

enum WebSocketOpCode {
  /// The initial message sent by obs-websocket to newly connected clients.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  hello(0),

  /// The message sent by a newly connected client to obs-websocket in response to a `Hello`.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  identify(1),

  /// The response sent by obs-websocket to a client after it has successfully identified with obs-websocket.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  identified(2),

  /// The message sent by an already-identified client to update identification parameters.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  reidentify(3),

  /// The message sent by obs-websocket containing an event payload.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  event(5),

  /// The message sent by a client to obs-websocket to perform a request.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  request(6),

  /// The message sent by obs-websocket in response to a particular request from a client.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  requestResponse(7),

  /// The message sent by a client to obs-websocket to perform a batch of requests.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  requestBatch(8),

  /// The message sent by obs-websocket in response to a particular batch of requests from a client.
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  requestBatchResponse(9);

  final int value;
  const WebSocketOpCode(this.value);
  static WebSocketOpCode fromInt(int n) => WebSocketOpCode.values.firstWhere((val) => val.value == n);
}

