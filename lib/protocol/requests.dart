import 'responses.dart';
import '../obs_ws.dart';
import '../classes/request_response.dart';

extension Protocol on OBSWebSocket {
  /// Gets the value of a "slot" from the selected persistent data realm.
  /// * Category: Config
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [realm]: The data realm to select. `OBS_WEBSOCKET_DATA_REALM_GLOBAL` or `OBS_WEBSOCKET_DATA_REALM_PROFILE`
  /// * [slotName]: The name of the slot to retrieve data from
  Future<GetPersistentDataResponse> getPersistentData({required String realm, required String slotName}) async => GetPersistentDataResponse.fromResponse(await call("GetPersistentData", {"realm": realm, "slotName": slotName}));

  /// Sets the value of a "slot" from the selected persistent data realm.
  /// * Category: Config
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [realm]: The data realm to select. `OBS_WEBSOCKET_DATA_REALM_GLOBAL` or `OBS_WEBSOCKET_DATA_REALM_PROFILE`
  /// * [slotName]: The name of the slot to retrieve data from
  /// * [slotValue]: The value to apply to the slot
  Future<GenericResponse> setPersistentData({required String realm, required String slotName, required dynamic slotValue}) async => call("SetPersistentData", {"realm": realm, "slotName": slotName, "slotValue": slotValue});

  /// Gets an array of all scene collections
  /// * Category: Config
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetSceneCollectionListResponse> getSceneCollectionList() async => GetSceneCollectionListResponse.fromResponse(await call("GetSceneCollectionList"));

  /// Switches to a scene collection.
  /// 
  /// Note: This will block until the collection has finished changing.
  /// * Category: Config
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneCollectionName]: Name of the scene collection to switch to
  Future<GenericResponse> setCurrentSceneCollection({required String sceneCollectionName}) async => call("SetCurrentSceneCollection", {"sceneCollectionName": sceneCollectionName});

  /// Creates a new scene collection, switching to it in the process.
  /// 
  /// Note: This will block until the collection has finished changing.
  /// * Category: Config
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneCollectionName]: Name for the new scene collection
  Future<GenericResponse> createSceneCollection({required String sceneCollectionName}) async => call("CreateSceneCollection", {"sceneCollectionName": sceneCollectionName});

  /// Gets an array of all profiles
  /// * Category: Config
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetProfileListResponse> getProfileList() async => GetProfileListResponse.fromResponse(await call("GetProfileList"));

  /// Switches to a profile.
  /// * Category: Config
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [profileName]: Name of the profile to switch to
  Future<GenericResponse> setCurrentProfile({required String profileName}) async => call("SetCurrentProfile", {"profileName": profileName});

  /// Creates a new profile, switching to it in the process
  /// * Category: Config
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [profileName]: Name for the new profile
  Future<GenericResponse> createProfile({required String profileName}) async => call("CreateProfile", {"profileName": profileName});

  /// Removes a profile. If the current profile is chosen, it will change to a different profile first.
  /// * Category: Config
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [profileName]: Name of the profile to remove
  Future<GenericResponse> removeProfile({required String profileName}) async => call("RemoveProfile", {"profileName": profileName});

  /// Gets a parameter from the current profile's configuration.
  /// * Category: Config
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [parameterCategory]: Category of the parameter to get
  /// * [parameterName]: Name of the parameter to get
  Future<GetProfileParameterResponse> getProfileParameter({required String parameterCategory, required String parameterName}) async => GetProfileParameterResponse.fromResponse(await call("GetProfileParameter", {"parameterCategory": parameterCategory, "parameterName": parameterName}));

  /// Sets the value of a parameter in the current profile's configuration.
  /// * Category: Config
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [parameterCategory]: Category of the parameter to set
  /// * [parameterName]: Name of the parameter to set
  /// * [parameterValue]: Value of the parameter to set. Use `null` to delete
  Future<GenericResponse> setProfileParameter({required String parameterCategory, required String parameterName, required String parameterValue}) async => call("SetProfileParameter", {"parameterCategory": parameterCategory, "parameterName": parameterName, "parameterValue": parameterValue});

  /// Gets the current video settings.
  /// 
  /// Note: To get the true FPS value, divide the FPS numerator by the FPS denominator. Example: `60000/1001`
  /// * Category: Config
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetVideoSettingsResponse> getVideoSettings() async => GetVideoSettingsResponse.fromResponse(await call("GetVideoSettings"));

  /// Sets the current video settings.
  /// 
  /// Note: Fields must be specified in pairs. For example, you cannot set only `baseWidth` without needing to specify `baseHeight`.
  /// * Category: Config
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [fpsNumerator]: Numerator of the fractional FPS value
  /// * [fpsDenominator]: Denominator of the fractional FPS value
  /// * [baseWidth]: Width of the base (canvas) resolution in pixels
  /// * [baseHeight]: Height of the base (canvas) resolution in pixels
  /// * [outputWidth]: Width of the output resolution in pixels
  /// * [outputHeight]: Height of the output resolution in pixels
  Future<GenericResponse> setVideoSettings({num? fpsNumerator, num? fpsDenominator, num? baseWidth, num? baseHeight, num? outputWidth, num? outputHeight}) async => call("SetVideoSettings", {if (fpsNumerator != null) "fpsNumerator": fpsNumerator, if (fpsDenominator != null) "fpsDenominator": fpsDenominator, if (baseWidth != null) "baseWidth": baseWidth, if (baseHeight != null) "baseHeight": baseHeight, if (outputWidth != null) "outputWidth": outputWidth, if (outputHeight != null) "outputHeight": outputHeight});

  /// Gets the current stream service settings (stream destination).
  /// * Category: Config
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetStreamServiceSettingsResponse> getStreamServiceSettings() async => GetStreamServiceSettingsResponse.fromResponse(await call("GetStreamServiceSettings"));

  /// Sets the current stream service settings (stream destination).
  /// 
  /// Note: Simple RTMP settings can be set with type `rtmp_custom` and the settings fields `server` and `key`.
  /// * Category: Config
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [streamServiceType]: Type of stream service to apply. Example: `rtmp_common` or `rtmp_custom`
  /// * [streamServiceSettings]: Settings to apply to the service
  Future<GenericResponse> setStreamServiceSettings({required String streamServiceType, required Map<String, dynamic> streamServiceSettings}) async => call("SetStreamServiceSettings", {"streamServiceType": streamServiceType, "streamServiceSettings": streamServiceSettings});

  /// Gets the current directory that the record output is set to.
  /// * Category: Rconfig
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetRecordDirectoryResponse> getRecordDirectory() async => GetRecordDirectoryResponse.fromResponse(await call("GetRecordDirectory"));

  /// Gets an array of all of a source's filters.
  /// * Category: Filters
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source
  Future<GetSourceFilterListResponse> getSourceFilterList({required String sourceName}) async => GetSourceFilterListResponse.fromResponse(await call("GetSourceFilterList", {"sourceName": sourceName}));

  /// Gets the default settings for a filter kind.
  /// * Category: Filters
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [filterKind]: Filter kind to get the default settings for
  Future<GetSourceFilterDefaultSettingsResponse> getSourceFilterDefaultSettings({required String filterKind}) async => GetSourceFilterDefaultSettingsResponse.fromResponse(await call("GetSourceFilterDefaultSettings", {"filterKind": filterKind}));

  /// Creates a new filter, adding it to the specified source.
  /// * Category: Filters
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source to add the filter to
  /// * [filterName]: Name of the new filter to be created
  /// * [filterKind]: The kind of filter to be created
  /// * [filterSettings]: Settings object to initialize the filter with
  Future<GenericResponse> createSourceFilter({required String sourceName, required String filterName, required String filterKind, Map<String, dynamic>? filterSettings}) async => call("CreateSourceFilter", {"sourceName": sourceName, "filterName": filterName, "filterKind": filterKind, if (filterSettings != null) "filterSettings": filterSettings});

  /// Removes a filter from a source.
  /// * Category: Filters
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source the filter is on
  /// * [filterName]: Name of the filter to remove
  Future<GenericResponse> removeSourceFilter({required String sourceName, required String filterName}) async => call("RemoveSourceFilter", {"sourceName": sourceName, "filterName": filterName});

  /// Sets the name of a source filter (rename).
  /// * Category: Filters
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source the filter is on
  /// * [filterName]: Current name of the filter
  /// * [newFilterName]: New name for the filter
  Future<GenericResponse> setSourceFilterName({required String sourceName, required String filterName, required String newFilterName}) async => call("SetSourceFilterName", {"sourceName": sourceName, "filterName": filterName, "newFilterName": newFilterName});

  /// Gets the info for a specific source filter.
  /// * Category: Filters
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source
  /// * [filterName]: Name of the filter
  Future<GetSourceFilterResponse> getSourceFilter({required String sourceName, required String filterName}) async => GetSourceFilterResponse.fromResponse(await call("GetSourceFilter", {"sourceName": sourceName, "filterName": filterName}));

  /// Sets the index position of a filter on a source.
  /// * Category: Filters
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source the filter is on
  /// * [filterName]: Name of the filter
  /// * [filterIndex]: New index position of the filter
  Future<GenericResponse> setSourceFilterIndex({required String sourceName, required String filterName, required num filterIndex}) async => call("SetSourceFilterIndex", {"sourceName": sourceName, "filterName": filterName, "filterIndex": filterIndex});

  /// Sets the settings of a source filter.
  /// * Category: Filters
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source the filter is on
  /// * [filterName]: Name of the filter to set the settings of
  /// * [filterSettings]: Object of settings to apply
  /// * [overlay]: True == apply the settings on top of existing ones, False == reset the input to its defaults, then apply settings.
  Future<GenericResponse> setSourceFilterSettings({required String sourceName, required String filterName, required Map<String, dynamic> filterSettings, bool? overlay}) async => call("SetSourceFilterSettings", {"sourceName": sourceName, "filterName": filterName, "filterSettings": filterSettings, if (overlay != null) "overlay": overlay});

  /// Sets the enable state of a source filter.
  /// * Category: Filters
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source the filter is on
  /// * [filterName]: Name of the filter
  /// * [filterEnabled]: New enable state of the filter
  Future<GenericResponse> setSourceFilterEnabled({required String sourceName, required String filterName, required bool filterEnabled}) async => call("SetSourceFilterEnabled", {"sourceName": sourceName, "filterName": filterName, "filterEnabled": filterEnabled});

  /// Gets data about the current plugin and RPC version.
  /// * Category: General
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetVersionResponse> getVersion() async => GetVersionResponse.fromResponse(await call("GetVersion"));

  /// Gets statistics about OBS, obs-websocket, and the current session.
  /// * Category: General
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetStatsResponse> getStats() async => GetStatsResponse.fromResponse(await call("GetStats"));

  /// Broadcasts a `CustomEvent` to all WebSocket clients. Receivers are clients which are identified and subscribed.
  /// * Category: General
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [eventData]: Data payload to emit to all receivers
  Future<GenericResponse> broadcastCustomEvent({required Map<String, dynamic> eventData}) async => call("BroadcastCustomEvent", {"eventData": eventData});

  /// Call a request registered to a vendor.
  /// 
  /// A vendor is a unique name registered by a third-party plugin or script, which allows for custom requests and events to be added to obs-websocket.
  /// If a plugin or script implements vendor requests or events, documentation is expected to be provided with them.
  /// * Category: General
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [vendorName]: Name of the vendor to use
  /// * [requestType]: The request type to call
  /// * [requestData]: Object containing appropriate request data
  Future<CallVendorRequestResponse> callVendorRequest({required String vendorName, required String requestType, Map<String, dynamic>? requestData}) async => CallVendorRequestResponse.fromResponse(await call("CallVendorRequest", {"vendorName": vendorName, "requestType": requestType, if (requestData != null) "requestData": requestData}));

  /// Gets an array of all hotkey names in OBS
  /// * Category: General
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetHotkeyListResponse> getHotkeyList() async => GetHotkeyListResponse.fromResponse(await call("GetHotkeyList"));

  /// Triggers a hotkey using its name. See `GetHotkeyList`
  /// * Category: General
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [hotkeyName]: Name of the hotkey to trigger
  Future<GenericResponse> triggerHotkeyByName({required String hotkeyName}) async => call("TriggerHotkeyByName", {"hotkeyName": hotkeyName});

  /// Triggers a hotkey using a sequence of keys.
  /// * Category: General
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [keyId]: The OBS key ID to use. See https://github.com/obsproject/obs-studio/blob/master/libobs/obs-hotkeys.h
  /// * [keyModifiers]: Object containing key modifiers to apply
  /// * [keyModifiers.shift]: Press Shift
  /// * [keyModifiers.control]: Press CTRL
  /// * [keyModifiers.alt]: Press ALT
  /// * [keyModifiers.command]: Press CMD (Mac)
  Future<GenericResponse> triggerHotkeyByKeySequence({String? keyId, Map<String, dynamic>? keyModifiers}) async => call("TriggerHotkeyByKeySequence", {if (keyId != null) "keyId": keyId, if (keyModifiers != null) "keyModifiers": keyModifiers});

  /// Sleeps for a time duration or number of frames. Only available in request batches with types `SERIAL_REALTIME` or `SERIAL_FRAME`.
  /// * Category: General
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sleepMillis]: Number of milliseconds to sleep for (if `SERIAL_REALTIME` mode)
  /// * [sleepFrames]: Number of frames to sleep for (if `SERIAL_FRAME` mode)
  Future<GenericResponse> sleep({required num sleepMillis, required num sleepFrames}) async => call("Sleep", {"sleepMillis": sleepMillis, "sleepFrames": sleepFrames});

  /// Gets an array of all inputs in OBS.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputKind]: Restrict the array to only inputs of the specified kind
  Future<GetInputListResponse> getInputList({String? inputKind}) async => GetInputListResponse.fromResponse(await call("GetInputList", {if (inputKind != null) "inputKind": inputKind}));

  /// Gets an array of all available input kinds in OBS.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [unversioned]: True == Return all kinds as unversioned, False == Return with version suffixes (if available)
  Future<GetInputKindListResponse> getInputKindList({bool? unversioned}) async => GetInputKindListResponse.fromResponse(await call("GetInputKindList", {if (unversioned != null) "unversioned": unversioned}));

  /// Gets the names of all special inputs.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetSpecialInputsResponse> getSpecialInputs() async => GetSpecialInputsResponse.fromResponse(await call("GetSpecialInputs"));

  /// Creates a new input, adding it as a scene item to the specified scene.
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene to add the input to as a scene item
  /// * [inputName]: Name of the new input to created
  /// * [inputKind]: The kind of input to be created
  /// * [inputSettings]: Settings object to initialize the input with
  /// * [sceneItemEnabled]: Whether to set the created scene item to enabled or disabled
  Future<CreateInputResponse> createInput({required String sceneName, required String inputName, required String inputKind, Map<String, dynamic>? inputSettings, bool? sceneItemEnabled}) async => CreateInputResponse.fromResponse(await call("CreateInput", {"sceneName": sceneName, "inputName": inputName, "inputKind": inputKind, if (inputSettings != null) "inputSettings": inputSettings, if (sceneItemEnabled != null) "sceneItemEnabled": sceneItemEnabled}));

  /// Removes an existing input.
  /// 
  /// Note: Will immediately remove all associated scene items.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to remove
  Future<GenericResponse> removeInput({required String inputName}) async => call("RemoveInput", {"inputName": inputName});

  /// Sets the name of an input (rename).
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Current input name
  /// * [newInputName]: New name for the input
  Future<GenericResponse> setInputName({required String inputName, required String newInputName}) async => call("SetInputName", {"inputName": inputName, "newInputName": newInputName});

  /// Gets the default settings for an input kind.
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputKind]: Input kind to get the default settings for
  Future<GetInputDefaultSettingsResponse> getInputDefaultSettings({required String inputKind}) async => GetInputDefaultSettingsResponse.fromResponse(await call("GetInputDefaultSettings", {"inputKind": inputKind}));

  /// Gets the settings of an input.
  /// 
  /// Note: Does not include defaults. To create the entire settings object, overlay `inputSettings` over the `defaultInputSettings` provided by `GetInputDefaultSettings`.
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to get the settings of
  Future<GetInputSettingsResponse> getInputSettings({required String inputName}) async => GetInputSettingsResponse.fromResponse(await call("GetInputSettings", {"inputName": inputName}));

  /// Sets the settings of an input.
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to set the settings of
  /// * [inputSettings]: Object of settings to apply
  /// * [overlay]: True == apply the settings on top of existing ones, False == reset the input to its defaults, then apply settings.
  Future<GenericResponse> setInputSettings({required String inputName, required Map<String, dynamic> inputSettings, bool? overlay}) async => call("SetInputSettings", {"inputName": inputName, "inputSettings": inputSettings, if (overlay != null) "overlay": overlay});

  /// Gets the audio mute state of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of input to get the mute state of
  Future<GetInputMuteResponse> getInputMute({required String inputName}) async => GetInputMuteResponse.fromResponse(await call("GetInputMute", {"inputName": inputName}));

  /// Sets the audio mute state of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to set the mute state of
  /// * [inputMuted]: Whether to mute the input or not
  Future<GenericResponse> setInputMute({required String inputName, required bool inputMuted}) async => call("SetInputMute", {"inputName": inputName, "inputMuted": inputMuted});

  /// Toggles the audio mute state of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to toggle the mute state of
  Future<ToggleInputMuteResponse> toggleInputMute({required String inputName}) async => ToggleInputMuteResponse.fromResponse(await call("ToggleInputMute", {"inputName": inputName}));

  /// Gets the current volume setting of an input.
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to get the volume of
  Future<GetInputVolumeResponse> getInputVolume({required String inputName}) async => GetInputVolumeResponse.fromResponse(await call("GetInputVolume", {"inputName": inputName}));

  /// Sets the volume setting of an input.
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to set the volume of
  /// * [inputVolumeMul]: Volume setting in mul
  /// * [inputVolumeDb]: Volume setting in dB
  Future<GenericResponse> setInputVolume({required String inputName, num? inputVolumeMul, num? inputVolumeDb}) async => call("SetInputVolume", {"inputName": inputName, if (inputVolumeMul != null) "inputVolumeMul": inputVolumeMul, if (inputVolumeDb != null) "inputVolumeDb": inputVolumeDb});

  /// Gets the audio balance of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to get the audio balance of
  Future<GetInputAudioBalanceResponse> getInputAudioBalance({required String inputName}) async => GetInputAudioBalanceResponse.fromResponse(await call("GetInputAudioBalance", {"inputName": inputName}));

  /// Sets the audio balance of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to set the audio balance of
  /// * [inputAudioBalance]: New audio balance value
  Future<GenericResponse> setInputAudioBalance({required String inputName, required num inputAudioBalance}) async => call("SetInputAudioBalance", {"inputName": inputName, "inputAudioBalance": inputAudioBalance});

  /// Gets the audio sync offset of an input.
  /// 
  /// Note: The audio sync offset can be negative too!
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to get the audio sync offset of
  Future<GetInputAudioSyncOffsetResponse> getInputAudioSyncOffset({required String inputName}) async => GetInputAudioSyncOffsetResponse.fromResponse(await call("GetInputAudioSyncOffset", {"inputName": inputName}));

  /// Sets the audio sync offset of an input.
  /// * Category: Inputs
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to set the audio sync offset of
  /// * [inputAudioSyncOffset]: New audio sync offset in milliseconds
  Future<GenericResponse> setInputAudioSyncOffset({required String inputName, required num inputAudioSyncOffset}) async => call("SetInputAudioSyncOffset", {"inputName": inputName, "inputAudioSyncOffset": inputAudioSyncOffset});

  /// Gets the audio monitor type of an input.
  /// 
  /// The available audio monitor types are:
  /// 
  /// - `OBS_MONITORING_TYPE_NONE`
  /// - `OBS_MONITORING_TYPE_MONITOR_ONLY`
  /// - `OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT`
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to get the audio monitor type of
  Future<GetInputAudioMonitorTypeResponse> getInputAudioMonitorType({required String inputName}) async => GetInputAudioMonitorTypeResponse.fromResponse(await call("GetInputAudioMonitorType", {"inputName": inputName}));

  /// Sets the audio monitor type of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to set the audio monitor type of
  /// * [monitorType]: Audio monitor type
  Future<GenericResponse> setInputAudioMonitorType({required String inputName, required String monitorType}) async => call("SetInputAudioMonitorType", {"inputName": inputName, "monitorType": monitorType});

  /// Gets the enable state of all audio tracks of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input
  Future<GetInputAudioTracksResponse> getInputAudioTracks({required String inputName}) async => GetInputAudioTracksResponse.fromResponse(await call("GetInputAudioTracks", {"inputName": inputName}));

  /// Sets the enable state of audio tracks of an input.
  /// * Category: Inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input
  /// * [inputAudioTracks]: Track settings to apply
  Future<GenericResponse> setInputAudioTracks({required String inputName, required Map<String, dynamic> inputAudioTracks}) async => call("SetInputAudioTracks", {"inputName": inputName, "inputAudioTracks": inputAudioTracks});

  /// Gets the items of a list property from an input's properties.
  /// 
  /// Note: Use this in cases where an input provides a dynamic, selectable list of items. For example, display capture, where it provides a list of available displays.
  /// * Category: Inputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input
  /// * [propertyName]: Name of the list property to get the items of
  Future<GetInputPropertiesListPropertyItemsResponse> getInputPropertiesListPropertyItems({required String inputName, required String propertyName}) async => GetInputPropertiesListPropertyItemsResponse.fromResponse(await call("GetInputPropertiesListPropertyItems", {"inputName": inputName, "propertyName": propertyName}));

  /// Presses a button in the properties of an input.
  /// 
  /// Note: Use this in cases where there is a button in the properties of an input that cannot be accessed in any other way. For example, browser sources, where there is a refresh button.
  /// * Category: Inputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input
  /// * [propertyName]: Name of the button property to press
  Future<GenericResponse> pressInputPropertiesButton({required String inputName, required String propertyName}) async => call("PressInputPropertiesButton", {"inputName": inputName, "propertyName": propertyName});

  /// Gets the status of a media input.
  /// 
  /// Media States:
  /// 
  /// - `OBS_MEDIA_STATE_NONE`
  /// - `OBS_MEDIA_STATE_PLAYING`
  /// - `OBS_MEDIA_STATE_OPENING`
  /// - `OBS_MEDIA_STATE_BUFFERING`
  /// - `OBS_MEDIA_STATE_PAUSED`
  /// - `OBS_MEDIA_STATE_STOPPED`
  /// - `OBS_MEDIA_STATE_ENDED`
  /// - `OBS_MEDIA_STATE_ERROR`
  /// * Category: Media inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the media input
  Future<GetMediaInputStatusResponse> getMediaInputStatus({required String inputName}) async => GetMediaInputStatusResponse.fromResponse(await call("GetMediaInputStatus", {"inputName": inputName}));

  /// Sets the cursor position of a media input.
  /// 
  /// This request does not perform bounds checking of the cursor position.
  /// * Category: Media inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the media input
  /// * [mediaCursor]: New cursor position to set
  Future<GenericResponse> setMediaInputCursor({required String inputName, required num mediaCursor}) async => call("SetMediaInputCursor", {"inputName": inputName, "mediaCursor": mediaCursor});

  /// Offsets the current cursor position of a media input by the specified value.
  /// 
  /// This request does not perform bounds checking of the cursor position.
  /// * Category: Media inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the media input
  /// * [mediaCursorOffset]: Value to offset the current cursor position by
  Future<GenericResponse> offsetMediaInputCursor({required String inputName, required num mediaCursorOffset}) async => call("OffsetMediaInputCursor", {"inputName": inputName, "mediaCursorOffset": mediaCursorOffset});

  /// Triggers an action on a media input.
  /// * Category: Media inputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the media input
  /// * [mediaAction]: Identifier of the `ObsMediaInputAction` enum
  Future<GenericResponse> triggerMediaInputAction({required String inputName, required String mediaAction}) async => call("TriggerMediaInputAction", {"inputName": inputName, "mediaAction": mediaAction});

  /// Gets the status of the virtualcam output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetVirtualCamStatusResponse> getVirtualCamStatus() async => GetVirtualCamStatusResponse.fromResponse(await call("GetVirtualCamStatus"));

  /// Toggles the state of the virtualcam output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<ToggleVirtualCamResponse> toggleVirtualCam() async => ToggleVirtualCamResponse.fromResponse(await call("ToggleVirtualCam"));

  /// Starts the virtualcam output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> startVirtualCam() async => call("StartVirtualCam");

  /// Stops the virtualcam output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> stopVirtualCam() async => call("StopVirtualCam");

  /// Gets the status of the replay buffer output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetReplayBufferStatusResponse> getReplayBufferStatus() async => GetReplayBufferStatusResponse.fromResponse(await call("GetReplayBufferStatus"));

  /// Toggles the state of the replay buffer output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<ToggleReplayBufferResponse> toggleReplayBuffer() async => ToggleReplayBufferResponse.fromResponse(await call("ToggleReplayBuffer"));

  /// Starts the replay buffer output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> startReplayBuffer() async => call("StartReplayBuffer");

  /// Stops the replay buffer output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> stopReplayBuffer() async => call("StopReplayBuffer");

  /// Saves the contents of the replay buffer output.
  /// * Category: Outputs
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> saveReplayBuffer() async => call("SaveReplayBuffer");

  /// Gets the filename of the last replay buffer save file.
  /// * Category: Outputs
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetLastReplayBufferReplayResponse> getLastReplayBufferReplay() async => GetLastReplayBufferReplayResponse.fromResponse(await call("GetLastReplayBufferReplay"));

  /// Gets the list of available outputs.
  /// * Category: Outputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> getOutputList() async => call("GetOutputList");

  /// Gets the status of an output.
  /// * Category: Outputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [outputName]: Output name
  Future<GetOutputStatusResponse> getOutputStatus({required String outputName}) async => GetOutputStatusResponse.fromResponse(await call("GetOutputStatus", {"outputName": outputName}));

  /// Toggles the status of an output.
  /// * Category: Outputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [outputName]: Output name
  Future<ToggleOutputResponse> toggleOutput({required String outputName}) async => ToggleOutputResponse.fromResponse(await call("ToggleOutput", {"outputName": outputName}));

  /// Starts an output.
  /// * Category: Outputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [outputName]: Output name
  Future<GenericResponse> startOutput({required String outputName}) async => call("StartOutput", {"outputName": outputName});

  /// Stops an output.
  /// * Category: Outputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [outputName]: Output name
  Future<GenericResponse> stopOutput({required String outputName}) async => call("StopOutput", {"outputName": outputName});

  /// Gets the settings of an output.
  /// * Category: Outputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [outputName]: Output name
  Future<GetOutputSettingsResponse> getOutputSettings({required String outputName}) async => GetOutputSettingsResponse.fromResponse(await call("GetOutputSettings", {"outputName": outputName}));

  /// Sets the settings of an output.
  /// * Category: Outputs
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [outputName]: Output name
  /// * [outputSettings]: Output settings
  Future<GenericResponse> setOutputSettings({required String outputName, required Map<String, dynamic> outputSettings}) async => call("SetOutputSettings", {"outputName": outputName, "outputSettings": outputSettings});

  /// Gets the status of the record output.
  /// * Category: Record
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetRecordStatusResponse> getRecordStatus() async => GetRecordStatusResponse.fromResponse(await call("GetRecordStatus"));

  /// Toggles the status of the record output.
  /// * Category: Record
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> toggleRecord() async => call("ToggleRecord");

  /// Starts the record output.
  /// * Category: Record
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> startRecord() async => call("StartRecord");

  /// Stops the record output.
  /// * Category: Record
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<StopRecordResponse> stopRecord() async => StopRecordResponse.fromResponse(await call("StopRecord"));

  /// Toggles pause on the record output.
  /// * Category: Record
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> toggleRecordPause() async => call("ToggleRecordPause");

  /// Pauses the record output.
  /// * Category: Record
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> pauseRecord() async => call("PauseRecord");

  /// Resumes the record output.
  /// * Category: Record
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> resumeRecord() async => call("ResumeRecord");

  /// Gets a list of all scene items in a scene.
  /// 
  /// Scenes only
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene to get the items of
  Future<GetSceneItemListResponse> getSceneItemList({required String sceneName}) async => GetSceneItemListResponse.fromResponse(await call("GetSceneItemList", {"sceneName": sceneName}));

  /// Basically GetSceneItemList, but for groups.
  /// 
  /// Using groups at all in OBS is discouraged, as they are very broken under the hood.
  /// 
  /// Groups only
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the group to get the items of
  Future<GetGroupSceneItemListResponse> getGroupSceneItemList({required String sceneName}) async => GetGroupSceneItemListResponse.fromResponse(await call("GetGroupSceneItemList", {"sceneName": sceneName}));

  /// Searches a scene for a source, and returns its id.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene or group to search in
  /// * [sourceName]: Name of the source to find
  /// * [searchOffset]: Number of matches to skip during search. >= 0 means first forward. -1 means last (top) item
  Future<GetSceneItemIdResponse> getSceneItemId({required String sceneName, required String sourceName, num? searchOffset}) async => GetSceneItemIdResponse.fromResponse(await call("GetSceneItemId", {"sceneName": sceneName, "sourceName": sourceName, if (searchOffset != null) "searchOffset": searchOffset}));

  /// Creates a new scene item using a source.
  /// 
  /// Scenes only
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene to create the new item in
  /// * [sourceName]: Name of the source to add to the scene
  /// * [sceneItemEnabled]: Enable state to apply to the scene item on creation
  Future<CreateSceneItemResponse> createSceneItem({required String sceneName, required String sourceName, bool? sceneItemEnabled}) async => CreateSceneItemResponse.fromResponse(await call("CreateSceneItem", {"sceneName": sceneName, "sourceName": sourceName, if (sceneItemEnabled != null) "sceneItemEnabled": sceneItemEnabled}));

  /// Removes a scene item from a scene.
  /// 
  /// Scenes only
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  Future<GenericResponse> removeSceneItem({required String sceneName, required num sceneItemId}) async => call("RemoveSceneItem", {"sceneName": sceneName, "sceneItemId": sceneItemId});

  /// Duplicates a scene item, copying all transform and crop info.
  /// 
  /// Scenes only
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  /// * [destinationSceneName]: Name of the scene to create the duplicated item in
  Future<DuplicateSceneItemResponse> duplicateSceneItem({required String sceneName, required num sceneItemId, String? destinationSceneName}) async => DuplicateSceneItemResponse.fromResponse(await call("DuplicateSceneItem", {"sceneName": sceneName, "sceneItemId": sceneItemId, if (destinationSceneName != null) "destinationSceneName": destinationSceneName}));

  /// Gets the transform and crop info of a scene item.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  Future<GetSceneItemTransformResponse> getSceneItemTransform({required String sceneName, required num sceneItemId}) async => GetSceneItemTransformResponse.fromResponse(await call("GetSceneItemTransform", {"sceneName": sceneName, "sceneItemId": sceneItemId}));

  /// Sets the transform and crop info of a scene item.
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  /// * [sceneItemTransform]: Object containing scene item transform info to update
  Future<GenericResponse> setSceneItemTransform({required String sceneName, required num sceneItemId, required Map<String, dynamic> sceneItemTransform}) async => call("SetSceneItemTransform", {"sceneName": sceneName, "sceneItemId": sceneItemId, "sceneItemTransform": sceneItemTransform});

  /// Gets the enable state of a scene item.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  Future<GetSceneItemEnabledResponse> getSceneItemEnabled({required String sceneName, required num sceneItemId}) async => GetSceneItemEnabledResponse.fromResponse(await call("GetSceneItemEnabled", {"sceneName": sceneName, "sceneItemId": sceneItemId}));

  /// Sets the enable state of a scene item.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  /// * [sceneItemEnabled]: New enable state of the scene item
  Future<GenericResponse> setSceneItemEnabled({required String sceneName, required num sceneItemId, required bool sceneItemEnabled}) async => call("SetSceneItemEnabled", {"sceneName": sceneName, "sceneItemId": sceneItemId, "sceneItemEnabled": sceneItemEnabled});

  /// Gets the lock state of a scene item.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  Future<GetSceneItemLockedResponse> getSceneItemLocked({required String sceneName, required num sceneItemId}) async => GetSceneItemLockedResponse.fromResponse(await call("GetSceneItemLocked", {"sceneName": sceneName, "sceneItemId": sceneItemId}));

  /// Sets the lock state of a scene item.
  /// 
  /// Scenes and Group
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  /// * [sceneItemLocked]: New lock state of the scene item
  Future<GenericResponse> setSceneItemLocked({required String sceneName, required num sceneItemId, required bool sceneItemLocked}) async => call("SetSceneItemLocked", {"sceneName": sceneName, "sceneItemId": sceneItemId, "sceneItemLocked": sceneItemLocked});

  /// Gets the index position of a scene item in a scene.
  /// 
  /// An index of 0 is at the bottom of the source list in the UI.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  Future<GetSceneItemIndexResponse> getSceneItemIndex({required String sceneName, required num sceneItemId}) async => GetSceneItemIndexResponse.fromResponse(await call("GetSceneItemIndex", {"sceneName": sceneName, "sceneItemId": sceneItemId}));

  /// Sets the index position of a scene item in a scene.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  /// * [sceneItemIndex]: New index position of the scene item
  Future<GenericResponse> setSceneItemIndex({required String sceneName, required num sceneItemId, required num sceneItemIndex}) async => call("SetSceneItemIndex", {"sceneName": sceneName, "sceneItemId": sceneItemId, "sceneItemIndex": sceneItemIndex});

  /// Gets the blend mode of a scene item.
  /// 
  /// Blend modes:
  /// 
  /// - `OBS_BLEND_NORMAL`
  /// - `OBS_BLEND_ADDITIVE`
  /// - `OBS_BLEND_SUBTRACT`
  /// - `OBS_BLEND_SCREEN`
  /// - `OBS_BLEND_MULTIPLY`
  /// - `OBS_BLEND_LIGHTEN`
  /// - `OBS_BLEND_DARKEN`
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  Future<GetSceneItemBlendModeResponse> getSceneItemBlendMode({required String sceneName, required num sceneItemId}) async => GetSceneItemBlendModeResponse.fromResponse(await call("GetSceneItemBlendMode", {"sceneName": sceneName, "sceneItemId": sceneItemId}));

  /// Sets the blend mode of a scene item.
  /// 
  /// Scenes and Groups
  /// * Category: Scene items
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene the item is in
  /// * [sceneItemId]: Numeric ID of the scene item
  /// * [sceneItemBlendMode]: New blend mode
  Future<GenericResponse> setSceneItemBlendMode({required String sceneName, required num sceneItemId, required String sceneItemBlendMode}) async => call("SetSceneItemBlendMode", {"sceneName": sceneName, "sceneItemId": sceneItemId, "sceneItemBlendMode": sceneItemBlendMode});

  /// Gets an array of all scenes in OBS.
  /// * Category: Scenes
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetSceneListResponse> getSceneList() async => GetSceneListResponse.fromResponse(await call("GetSceneList"));

  /// Gets an array of all groups in OBS.
  /// 
  /// Groups in OBS are actually scenes, but renamed and modified. In obs-websocket, we treat them as scenes where we can.
  /// * Category: Scenes
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetGroupListResponse> getGroupList() async => GetGroupListResponse.fromResponse(await call("GetGroupList"));

  /// Gets the current program scene.
  /// * Category: Scenes
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetCurrentProgramSceneResponse> getCurrentProgramScene() async => GetCurrentProgramSceneResponse.fromResponse(await call("GetCurrentProgramScene"));

  /// Sets the current program scene.
  /// * Category: Scenes
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Scene to set as the current program scene
  Future<GenericResponse> setCurrentProgramScene({required String sceneName}) async => call("SetCurrentProgramScene", {"sceneName": sceneName});

  /// Gets the current preview scene.
  /// 
  /// Only available when studio mode is enabled.
  /// * Category: Scenes
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetCurrentPreviewSceneResponse> getCurrentPreviewScene() async => GetCurrentPreviewSceneResponse.fromResponse(await call("GetCurrentPreviewScene"));

  /// Sets the current preview scene.
  /// 
  /// Only available when studio mode is enabled.
  /// * Category: Scenes
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Scene to set as the current preview scene
  Future<GenericResponse> setCurrentPreviewScene({required String sceneName}) async => call("SetCurrentPreviewScene", {"sceneName": sceneName});

  /// Creates a new scene in OBS.
  /// * Category: Scenes
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name for the new scene
  Future<GenericResponse> createScene({required String sceneName}) async => call("CreateScene", {"sceneName": sceneName});

  /// Removes a scene from OBS.
  /// * Category: Scenes
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene to remove
  Future<GenericResponse> removeScene({required String sceneName}) async => call("RemoveScene", {"sceneName": sceneName});

  /// Sets the name of a scene (rename).
  /// * Category: Scenes
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene to be renamed
  /// * [newSceneName]: New name for the scene
  Future<GenericResponse> setSceneName({required String sceneName, required String newSceneName}) async => call("SetSceneName", {"sceneName": sceneName, "newSceneName": newSceneName});

  /// Gets the scene transition overridden for a scene.
  /// * Category: Scenes
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene
  Future<GetSceneSceneTransitionOverrideResponse> getSceneSceneTransitionOverride({required String sceneName}) async => GetSceneSceneTransitionOverrideResponse.fromResponse(await call("GetSceneSceneTransitionOverride", {"sceneName": sceneName}));

  /// Gets the scene transition overridden for a scene.
  /// * Category: Scenes
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sceneName]: Name of the scene
  /// * [transitionName]: Name of the scene transition to use as override. Specify `null` to remove
  /// * [transitionDuration]: Duration to use for any overridden transition. Specify `null` to remove
  Future<GenericResponse> setSceneSceneTransitionOverride({required String sceneName, String? transitionName, num? transitionDuration}) async => call("SetSceneSceneTransitionOverride", {"sceneName": sceneName, if (transitionName != null) "transitionName": transitionName, if (transitionDuration != null) "transitionDuration": transitionDuration});

  /// Gets the active and show state of a source.
  /// 
  /// **Compatible with inputs and scenes.**
  /// * Category: Sources
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source to get the active state of
  Future<GetSourceActiveResponse> getSourceActive({required String sourceName}) async => GetSourceActiveResponse.fromResponse(await call("GetSourceActive", {"sourceName": sourceName}));

  /// Gets a Base64-encoded screenshot of a source.
  /// 
  /// The `imageWidth` and `imageHeight` parameters are treated as "scale to inner", meaning the smallest ratio will be used and the aspect ratio of the original resolution is kept.
  /// If `imageWidth` and `imageHeight` are not specified, the compressed image will use the full resolution of the source.
  /// 
  /// **Compatible with inputs and scenes.**
  /// * Category: Sources
  /// * Complexity: 4/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source to take a screenshot of
  /// * [imageFormat]: Image compression format to use. Use `GetVersion` to get compatible image formats
  /// * [imageWidth]: Width to scale the screenshot to
  /// * [imageHeight]: Height to scale the screenshot to
  /// * [imageCompressionQuality]: Compression quality to use. 0 for high compression, 100 for uncompressed. -1 to use "default" (whatever that means, idk)
  Future<GetSourceScreenshotResponse> getSourceScreenshot({required String sourceName, required String imageFormat, num? imageWidth, num? imageHeight, num? imageCompressionQuality}) async => GetSourceScreenshotResponse.fromResponse(await call("GetSourceScreenshot", {"sourceName": sourceName, "imageFormat": imageFormat, if (imageWidth != null) "imageWidth": imageWidth, if (imageHeight != null) "imageHeight": imageHeight, if (imageCompressionQuality != null) "imageCompressionQuality": imageCompressionQuality}));

  /// Saves a screenshot of a source to the filesystem.
  /// 
  /// The `imageWidth` and `imageHeight` parameters are treated as "scale to inner", meaning the smallest ratio will be used and the aspect ratio of the original resolution is kept.
  /// If `imageWidth` and `imageHeight` are not specified, the compressed image will use the full resolution of the source.
  /// 
  /// **Compatible with inputs and scenes.**
  /// * Category: Sources
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source to take a screenshot of
  /// * [imageFormat]: Image compression format to use. Use `GetVersion` to get compatible image formats
  /// * [imageFilePath]: Path to save the screenshot file to. Eg. `C: Users user Desktop screenshot.png`
  /// * [imageWidth]: Width to scale the screenshot to
  /// * [imageHeight]: Height to scale the screenshot to
  /// * [imageCompressionQuality]: Compression quality to use. 0 for high compression, 100 for uncompressed. -1 to use "default" (whatever that means, idk)
  Future<SaveSourceScreenshotResponse> saveSourceScreenshot({required String sourceName, required String imageFormat, required String imageFilePath, num? imageWidth, num? imageHeight, num? imageCompressionQuality}) async => SaveSourceScreenshotResponse.fromResponse(await call("SaveSourceScreenshot", {"sourceName": sourceName, "imageFormat": imageFormat, "imageFilePath": imageFilePath, if (imageWidth != null) "imageWidth": imageWidth, if (imageHeight != null) "imageHeight": imageHeight, if (imageCompressionQuality != null) "imageCompressionQuality": imageCompressionQuality}));

  /// Gets the status of the stream output.
  /// * Category: Stream
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetStreamStatusResponse> getStreamStatus() async => GetStreamStatusResponse.fromResponse(await call("GetStreamStatus"));

  /// Toggles the status of the stream output.
  /// * Category: Stream
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<ToggleStreamResponse> toggleStream() async => ToggleStreamResponse.fromResponse(await call("ToggleStream"));

  /// Starts the stream output.
  /// * Category: Stream
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> startStream() async => call("StartStream");

  /// Stops the stream output.
  /// * Category: Stream
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> stopStream() async => call("StopStream");

  /// Sends CEA-608 caption text over the stream output.
  /// * Category: Stream
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [captionText]: Caption text
  Future<GenericResponse> sendStreamCaption({required String captionText}) async => call("SendStreamCaption", {"captionText": captionText});

  /// Gets an array of all available transition kinds.
  /// 
  /// Similar to `GetInputKindList`
  /// * Category: Transitions
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetTransitionKindListResponse> getTransitionKindList() async => GetTransitionKindListResponse.fromResponse(await call("GetTransitionKindList"));

  /// Gets an array of all scene transitions in OBS.
  /// * Category: Transitions
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetSceneTransitionListResponse> getSceneTransitionList() async => GetSceneTransitionListResponse.fromResponse(await call("GetSceneTransitionList"));

  /// Gets information about the current scene transition.
  /// * Category: Transitions
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetCurrentSceneTransitionResponse> getCurrentSceneTransition() async => GetCurrentSceneTransitionResponse.fromResponse(await call("GetCurrentSceneTransition"));

  /// Sets the current scene transition.
  /// 
  /// Small note: While the namespace of scene transitions is generally unique, that uniqueness is not a guarantee as it is with other resources like inputs.
  /// * Category: Transitions
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [transitionName]: Name of the transition to make active
  Future<GenericResponse> setCurrentSceneTransition({required String transitionName}) async => call("SetCurrentSceneTransition", {"transitionName": transitionName});

  /// Sets the duration of the current scene transition, if it is not fixed.
  /// * Category: Transitions
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [transitionDuration]: Duration in milliseconds
  Future<GenericResponse> setCurrentSceneTransitionDuration({required num transitionDuration}) async => call("SetCurrentSceneTransitionDuration", {"transitionDuration": transitionDuration});

  /// Sets the settings of the current scene transition.
  /// * Category: Transitions
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [transitionSettings]: Settings object to apply to the transition. Can be `{}`
  /// * [overlay]: Whether to overlay over the current settings or replace them
  Future<GenericResponse> setCurrentSceneTransitionSettings({required Map<String, dynamic> transitionSettings, bool? overlay}) async => call("SetCurrentSceneTransitionSettings", {"transitionSettings": transitionSettings, if (overlay != null) "overlay": overlay});

  /// Gets the cursor position of the current scene transition.
  /// 
  /// Note: `transitionCursor` will return 1.0 when the transition is inactive.
  /// * Category: Transitions
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetCurrentSceneTransitionCursorResponse> getCurrentSceneTransitionCursor() async => GetCurrentSceneTransitionCursorResponse.fromResponse(await call("GetCurrentSceneTransitionCursor"));

  /// Triggers the current scene transition. Same functionality as the `Transition` button in studio mode.
  /// * Category: Transitions
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GenericResponse> triggerStudioModeTransition() async => call("TriggerStudioModeTransition");

  /// Sets the position of the TBar.
  /// 
  /// **Very important note**: This will be deprecated and replaced in a future version of obs-websocket.
  /// * Category: Transitions
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [position]: New position
  /// * [release]: Whether to release the TBar. Only set `false` if you know that you will be sending another position update
  Future<GenericResponse> setTBarPosition({required num position, bool? release}) async => call("SetTBarPosition", {"position": position, if (release != null) "release": release});

  /// Gets whether studio is enabled.
  /// * Category: Ui
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetStudioModeEnabledResponse> getStudioModeEnabled() async => GetStudioModeEnabledResponse.fromResponse(await call("GetStudioModeEnabled"));

  /// Enables or disables studio mode
  /// * Category: Ui
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [studioModeEnabled]: True == Enabled, False == Disabled
  Future<GenericResponse> setStudioModeEnabled({required bool studioModeEnabled}) async => call("SetStudioModeEnabled", {"studioModeEnabled": studioModeEnabled});

  /// Opens the properties dialog of an input.
  /// * Category: Ui
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to open the dialog of
  Future<GenericResponse> openInputPropertiesDialog({required String inputName}) async => call("OpenInputPropertiesDialog", {"inputName": inputName});

  /// Opens the filters dialog of an input.
  /// * Category: Ui
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to open the dialog of
  Future<GenericResponse> openInputFiltersDialog({required String inputName}) async => call("OpenInputFiltersDialog", {"inputName": inputName});

  /// Opens the interact dialog of an input.
  /// * Category: Ui
  /// * Complexity: 1/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [inputName]: Name of the input to open the dialog of
  Future<GenericResponse> openInputInteractDialog({required String inputName}) async => call("OpenInputInteractDialog", {"inputName": inputName});

  /// Gets a list of connected monitors and information about them.
  /// * Category: Ui
  /// * Complexity: 2/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  Future<GetMonitorListResponse> getMonitorList() async => GetMonitorListResponse.fromResponse(await call("GetMonitorList"));

  /// Opens a projector for a specific output video mix.
  /// 
  /// Mix types:
  /// 
  /// - `OBS_WEBSOCKET_VIDEO_MIX_TYPE_PREVIEW`
  /// - `OBS_WEBSOCKET_VIDEO_MIX_TYPE_PROGRAM`
  /// - `OBS_WEBSOCKET_VIDEO_MIX_TYPE_MULTIVIEW`
  /// 
  /// Note: This request serves to provide feature parity with 4.x. It is very likely to be changed/deprecated in a future release.
  /// * Category: Ui
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [videoMixType]: Type of mix to open
  /// * [monitorIndex]: Monitor index, use `GetMonitorList` to obtain index
  /// * [projectorGeometry]: Size/Position data for a windowed projector, in Qt Base64 encoded format. Mutually exclusive with `monitorIndex`
  Future<GenericResponse> openVideoMixProjector({required String videoMixType, num? monitorIndex, String? projectorGeometry}) async => call("OpenVideoMixProjector", {"videoMixType": videoMixType, if (monitorIndex != null) "monitorIndex": monitorIndex, if (projectorGeometry != null) "projectorGeometry": projectorGeometry});

  /// Opens a projector for a source.
  /// 
  /// Note: This request serves to provide feature parity with 4.x. It is very likely to be changed/deprecated in a future release.
  /// * Category: Ui
  /// * Complexity: 3/5
  /// * RPC Version: 1
  /// * Initial Version: 5.0.0
  /// 
  /// **Request fields:**
  /// * [sourceName]: Name of the source to open a projector for
  /// * [monitorIndex]: Monitor index, use `GetMonitorList` to obtain index
  /// * [projectorGeometry]: Size/Position data for a windowed projector, in Qt Base64 encoded format. Mutually exclusive with `monitorIndex`
  Future<GenericResponse> openSourceProjector({required String sourceName, num? monitorIndex, String? projectorGeometry}) async => call("OpenSourceProjector", {"sourceName": sourceName, if (monitorIndex != null) "monitorIndex": monitorIndex, if (projectorGeometry != null) "projectorGeometry": projectorGeometry});

}
