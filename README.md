# obs_ws
This Dart library provides a way to communicate with OBS Studio over the [obs-websocket plugin](https://github.com/obsproject/obs-websocket) protocol.

All requests, responses, events, and enums are auto-generated acccording to the [obs-websocket protocol](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md) using the `generate_protocol.py` script. All request/response names and fields are the same as specified in the protocol or were slightly changed to fit Dart function/class naming conventions (i.e. PascalCase to camelCase for request helper functions).

## Quick start
**A working program using these examples can be found in `example/example.dart`.**

Add package to `pubspec.yaml`:
```yml
dependencies:
    obs_ws: ^1.0.0
```

Import the package:
```dart
import 'package:obs_ws/obs_ws.dart';
```

Connect to obs-websocket:
```dart
void main() async {
  ObsWebSocket obs = await ObsWebSocket.connect("127.0.0.1",
      password: password, subscriptions: [ObsEventSubscription.all]);
}
```

Send a request:
```dart
var res = await obs.getSceneList();
print("Response code: ${res.status.code}");
print("Scenes: ${res.scenes}");
```

Send a batch request:
```dart
var req1 = GetSceneListRequest();
var req2 = GetStudioModeEnabledRequest();
var req3 = CreateSceneRequest(sceneName: "Test");
var res = await obs.sendBatchRequest([req1, req2, req3]);

// res will contain a list of generic OBSWebSocketResponses
// 
// If serializeResponses is set to true (default = true),
// you can use the response field from each request object.
print("Request 1 (GetSceneList): ${req1.response?.scenes}");
print("Request 2 (GetStudioModeEnabled): ${req2.response?.studioModeEnabled}");
print("Request 3 (CreateScene) Status: ${req3.response?.status.code.name}");
print("Responses: ${res}");
```

Listen for events:
```dart
obs.eventStream.listen((event) {
  print("Event type: ${event.type}");
  print("Event data (raw): ${event.data}");

  if (event is StudioModeStateChangedEvent) {
    print("Studio mode status: ${event.studioModeEnabled}");
  }
});
```

Disconnect:
```dart
await obs.disconnect();
```

Note that you can go as high-level or low-level as you want. For example, if you do not want to use the request/response classes and just want to use JSON, you can use `call`:
```dart
var res = await obs.call("GetInputVolume", {"inputName": "Mic/Aux"});
print(res.data["inputVolumeDb"])
```

If you want to go *even lower level*, you can send and receive all the ops manually:
```dart
String requestId = "meow";

ObsRequestOp requestOp = ObsRequestOp.create(
  requestType: "GetInputVolume",
  requestId: requestId,
  requestData: {
    "inputName": "Mic/Aux",
  },
);
obs.sendOp(requestOp);

ObsRequestResponseOp responseOp = await obs.waitForOpCode(ObsWebSocketOpCode.requestResponse);
if (responseOp.requestId == requestId &&
      responseOp.requestStatus.code == RequestStatus.success) {
  print(responseOp.responseData!["inputVolumeDb"]);
}

obs.opStream.listen((event) {
  if (event.code == ObsWebSocketOpCode.event) {
    print("Event type: ${event.data['eventType']}");
    print("Event data: ${event.data['eventData']}");
  }
});
```
The `Hello`-`Identify`-`Identified` process can also be done manually when connecting if `auto` is set to `false` when using `ObsWebSocket.connect` or `ObsWebSocket.connectUri`.
