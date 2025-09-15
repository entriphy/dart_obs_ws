import 'package:obs_ws/obs_ws.dart';

// Put obs-websocket password here
const String password = "yeet123";

void main() async {
  // Connect to obs-websocket
  ObsWebSocket obs = await ObsWebSocket.connect("127.0.0.1",
      password: password, subscriptions: []);

  // Update event subscriptions
  await obs.reidentify(subscriptions: [ObsEventSubscription.all]);

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
  // Note that these helper functions are provided as an extension on [OBSWebSocket]
  var sceneList = await obs.getSceneList();
  var currentScene = await obs.getCurrentProgramScene();
  var profileList = await obs.getProfileList();
  print("GetSceneList: ${sceneList.scenes}");
  print("GetCurrentProgramScene: ${currentScene.currentProgramSceneName}");
  print("GetProfileList: ${profileList.profiles}");
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
  var batchReq = await obs.sendBatchRequest([req1, req2, req3],
      executionType: ObsRequestBatchExecutionType.serialRealtime);
  var res1 = req1.response!;
  var res2 = req2.response!;
  var res3 = req3.response!;
  print("Request 1 (GetSceneList): ${res1.scenes}");
  print("Request 2 (GetStudioModeEnabled): ${res2.studioModeEnabled}");
  print("Request 3 (CreateScene) Status: ${res3.status.code.name}");
  print("Responses: ${batchReq.toString()}");
  await Future.delayed(Duration(seconds: 2));

  // Disconnect from obs-websocket after 15 seconds
  print("Disconnecting in 15 seconds");
  await Future.delayed(Duration(seconds: 15));
  await obs.disconnect();
}
