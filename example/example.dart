import 'package:obs_ws/obs_ws.dart';

// Put obs-websocket password here
const String password = "yeet123";

void main() async {
  // Connect to obs-websocket
  OBSWebSocket obs = await OBSWebSocket.connect("127.0.0.1",
      password: password, subscriptions: [EventSubscription.all]);

  // Listen for events
  obs.eventStream.listen((event) {
    print("Event emitted: ${event.type}");
    print("Event data: ${event.data}");

    if (event is SceneTransitionStartedEvent) {
      print("Transitioning: ${event.transitionName}");
    } else if (event is StudioModeStateChangedEvent) {
      print("Studio mode: ${event.studioModeEnabled}");
    }
  });

  // Send requests and print responses
  // Note that these heler functions are provided as an extension on [OBSWebSocket]
  print("GetSceneList: ${(await obs.getSceneList()).scenes}");
  print(
      "GetCurrentProgramScene: ${(await obs.getCurrentProgramScene()).currentProgramSceneName}");
  print("GetProfileList: ${(await obs.getProfileList()).profiles}");
  await Future.delayed(Duration(seconds: 2));

  // Second method to send requests
  GetCurrentProgramSceneRequest request = GetCurrentProgramSceneRequest();
  GetCurrentProgramSceneResponse response = await obs.sendRequest(request);
  print(response.currentProgramSceneName);
  // Or get the response from the request object
  print(request.response?.currentProgramSceneName);
  await Future.delayed(Duration(seconds: 2));

  // Third method to send requests
  var call = await obs.call("GetCurrentProgramScene");
  print(call.data["currentProgramSceneName"]);

  // Send batch request
  var req1 = GetSceneListRequest();
  var req2 = GetStudioModeEnabledRequest();
  var req3 = CreateSceneRequest(sceneName: "Test");
  var res = await obs.sendBatchRequest([req1, req2, req3],
      executionType: RequestBatchExecutionType.serialRealtime);
  print("Request 1 (GetSceneList): ${req1.response?.scenes}");
  print(
      "Request 2 (GetStudioModeEnabled): ${req2.response?.studioModeEnabled}");
  print("Request 3 (CreateScene) Status: ${req3.response?.status.code.name}");
  print("Responses: ${res.toString()}");
  await Future.delayed(Duration(seconds: 2));

  // Disconnect from obs-websocket after 15 seconds
  print("Disconnecting in 15 seconds");
  await Future.delayed(Duration(seconds: 15));
  await obs.disconnect();
}
