import 'package:obs_ws/obs_ws.dart';

// Put obs-websocket password here
const String password = "";

void main() async {
  // Connect to obs-websocket
  OBSWebSocket obs = await OBSWebSocket.connect("127.0.0.1");
  HelloOp hello = await obs.waitForOpCode(WebSocketOpCode.hello);

  // Authenticate (if required)
  String? authentication;
  if (hello.authentication != null) {
    authentication = OBSWebSocket.createAuthenticationString(
      password,
      hello.authentication!.challenge,
      hello.authentication!.salt,
    );
  }
  obs.sendOpCode(IdentifyOp.create(
    rpcVersion: hello.rpcVersion,
    authentication: authentication,
    eventSubscriptions: EventSubscription.all.value,
  ));

  // Wait for identification opcode
  try {
    await obs.waitForOpCode(WebSocketOpCode.identified);
  } catch (e) {
    if (obs.closeCode == WebSocketCloseCode.authenticationFailed) {
      print("The password provided is incorrect.");
    } else {
      rethrow;
    }
    return;
  }

  // Listen for events
  obs.eventStream.listen((event) {
    print("Event emitted: ${event.runtimeType}");
    if (event is SceneTransitionStartedEvent) {
      print(event.transitionName);
    } else if (event is StudioModeStateChangedEvent) {
      print(event.studioModeEnabled);
    }
  });

  // Send requests and print responses
  print((await obs.getProfileList()).currentProfileName);
  print((await obs.getSceneList()).scenes);
  print((await obs.getCurrentProgramScene()).currentProgramSceneName);
  await obs.createScene(sceneName: "Test");

  // Disconnect from obs-websocket after 15 seconds
  await Future.delayed(Duration(seconds: 15));
  await obs.disconnect();
}
