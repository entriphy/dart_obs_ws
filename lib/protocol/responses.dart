import '../classes/request_response.dart';

class GetPersistentDataResponse extends RequestResponse {
	/// Value associated with the slot. `null` if not set
	dynamic? get slotValue => data["slotValue"];

	GetPersistentDataResponse(data, status) : super(data, status);
	GetPersistentDataResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneCollectionListResponse extends RequestResponse {
	/// The name of the current scene collection
	String get currentSceneCollectionName => data["currentSceneCollectionName"];

	/// Array of all available scene collections
	List<String> get sceneCollections => data["sceneCollections"].cast<String>();

	GetSceneCollectionListResponse(data, status) : super(data, status);
	GetSceneCollectionListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetProfileListResponse extends RequestResponse {
	/// The name of the current profile
	String get currentProfileName => data["currentProfileName"];

	/// Array of all available profiles
	List<String> get profiles => data["profiles"].cast<String>();

	GetProfileListResponse(data, status) : super(data, status);
	GetProfileListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetProfileParameterResponse extends RequestResponse {
	/// Value associated with the parameter. `null` if not set and no default
	String? get parameterValue => data["parameterValue"];

	/// Default value associated with the parameter. `null` if no default
	String? get defaultParameterValue => data["defaultParameterValue"];

	GetProfileParameterResponse(data, status) : super(data, status);
	GetProfileParameterResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetVideoSettingsResponse extends RequestResponse {
	/// Numerator of the fractional FPS value
	num get fpsNumerator => data["fpsNumerator"];

	/// Denominator of the fractional FPS value
	num get fpsDenominator => data["fpsDenominator"];

	/// Width of the base (canvas) resolution in pixels
	num get baseWidth => data["baseWidth"];

	/// Height of the base (canvas) resolution in pixels
	num get baseHeight => data["baseHeight"];

	/// Width of the output resolution in pixels
	num get outputWidth => data["outputWidth"];

	/// Height of the output resolution in pixels
	num get outputHeight => data["outputHeight"];

	GetVideoSettingsResponse(data, status) : super(data, status);
	GetVideoSettingsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetStreamServiceSettingsResponse extends RequestResponse {
	/// Stream service type, like `rtmp_custom` or `rtmp_common`
	String get streamServiceType => data["streamServiceType"];

	/// Stream service settings
	Map<String, dynamic> get streamServiceSettings => data["streamServiceSettings"];

	GetStreamServiceSettingsResponse(data, status) : super(data, status);
	GetStreamServiceSettingsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetRecordDirectoryResponse extends RequestResponse {
	/// Output directory
	String get recordDirectory => data["recordDirectory"];

	GetRecordDirectoryResponse(data, status) : super(data, status);
	GetRecordDirectoryResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSourceFilterListResponse extends RequestResponse {
	/// Array of filters
	List<Map<String, dynamic>> get filters => data["filters"].cast<Map<String, dynamic>>();

	GetSourceFilterListResponse(data, status) : super(data, status);
	GetSourceFilterListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSourceFilterDefaultSettingsResponse extends RequestResponse {
	/// Object of default settings for the filter kind
	Map<String, dynamic> get defaultFilterSettings => data["defaultFilterSettings"];

	GetSourceFilterDefaultSettingsResponse(data, status) : super(data, status);
	GetSourceFilterDefaultSettingsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSourceFilterResponse extends RequestResponse {
	/// Whether the filter is enabled
	bool get filterEnabled => data["filterEnabled"];

	/// Index of the filter in the list, beginning at 0
	num get filterIndex => data["filterIndex"];

	/// The kind of filter
	String get filterKind => data["filterKind"];

	/// Settings object associated with the filter
	Map<String, dynamic> get filterSettings => data["filterSettings"];

	GetSourceFilterResponse(data, status) : super(data, status);
	GetSourceFilterResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetVersionResponse extends RequestResponse {
	/// Current OBS Studio version
	String get obsVersion => data["obsVersion"];

	/// Current obs-websocket version
	String get obsWebSocketVersion => data["obsWebSocketVersion"];

	/// Current latest obs-websocket RPC version
	num get rpcVersion => data["rpcVersion"];

	/// Array of available RPC requests for the currently negotiated RPC version
	List<String> get availableRequests => data["availableRequests"].cast<String>();

	/// Image formats available in `GetSourceScreenshot` and `SaveSourceScreenshot` requests.
	List<String> get supportedImageFormats => data["supportedImageFormats"].cast<String>();

	/// Name of the platform. Usually `windows`, `macos`, or `ubuntu` (linux flavor). Not guaranteed to be any of those
	String get platform => data["platform"];

	/// Description of the platform, like `Windows 10 (10.0)`
	String get platformDescription => data["platformDescription"];

	GetVersionResponse(data, status) : super(data, status);
	GetVersionResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetStatsResponse extends RequestResponse {
	/// Current CPU usage in percent
	num get cpuUsage => data["cpuUsage"];

	/// Amount of memory in MB currently being used by OBS
	num get memoryUsage => data["memoryUsage"];

	/// Available disk space on the device being used for recording storage
	num get availableDiskSpace => data["availableDiskSpace"];

	/// Current FPS being rendered
	num get activeFps => data["activeFps"];

	/// Average time in milliseconds that OBS is taking to render a frame
	num get averageFrameRenderTime => data["averageFrameRenderTime"];

	/// Number of frames skipped by OBS in the render thread
	num get renderSkippedFrames => data["renderSkippedFrames"];

	/// Total number of frames outputted by the render thread
	num get renderTotalFrames => data["renderTotalFrames"];

	/// Number of frames skipped by OBS in the output thread
	num get outputSkippedFrames => data["outputSkippedFrames"];

	/// Total number of frames outputted by the output thread
	num get outputTotalFrames => data["outputTotalFrames"];

	/// Total number of messages received by obs-websocket from the client
	num get webSocketSessionIncomingMessages => data["webSocketSessionIncomingMessages"];

	/// Total number of messages sent by obs-websocket to the client
	num get webSocketSessionOutgoingMessages => data["webSocketSessionOutgoingMessages"];

	GetStatsResponse(data, status) : super(data, status);
	GetStatsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class CallVendorRequestResponse extends RequestResponse {
	/// Echoed of `vendorName`
	String get vendorName => data["vendorName"];

	/// Echoed of `requestType`
	String get requestType => data["requestType"];

	/// Object containing appropriate response data. {} if request does not provide any response data
	Map<String, dynamic> get responseData => data["responseData"];

	CallVendorRequestResponse(data, status) : super(data, status);
	CallVendorRequestResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetHotkeyListResponse extends RequestResponse {
	/// Array of hotkey names
	List<String> get hotkeys => data["hotkeys"].cast<String>();

	GetHotkeyListResponse(data, status) : super(data, status);
	GetHotkeyListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputListResponse extends RequestResponse {
	/// Array of inputs
	List<Map<String, dynamic>> get inputs => data["inputs"].cast<Map<String, dynamic>>();

	GetInputListResponse(data, status) : super(data, status);
	GetInputListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputKindListResponse extends RequestResponse {
	/// Array of input kinds
	List<String> get inputKinds => data["inputKinds"].cast<String>();

	GetInputKindListResponse(data, status) : super(data, status);
	GetInputKindListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSpecialInputsResponse extends RequestResponse {
	/// Name of the Desktop Audio input
	String get desktop1 => data["desktop1"];

	/// Name of the Desktop Audio 2 input
	String get desktop2 => data["desktop2"];

	/// Name of the Mic/Auxiliary Audio input
	String get mic1 => data["mic1"];

	/// Name of the Mic/Auxiliary Audio 2 input
	String get mic2 => data["mic2"];

	/// Name of the Mic/Auxiliary Audio 3 input
	String get mic3 => data["mic3"];

	/// Name of the Mic/Auxiliary Audio 4 input
	String get mic4 => data["mic4"];

	GetSpecialInputsResponse(data, status) : super(data, status);
	GetSpecialInputsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class CreateInputResponse extends RequestResponse {
	/// ID of the newly created scene item
	num get sceneItemId => data["sceneItemId"];

	CreateInputResponse(data, status) : super(data, status);
	CreateInputResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputDefaultSettingsResponse extends RequestResponse {
	/// Object of default settings for the input kind
	Map<String, dynamic> get defaultInputSettings => data["defaultInputSettings"];

	GetInputDefaultSettingsResponse(data, status) : super(data, status);
	GetInputDefaultSettingsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputSettingsResponse extends RequestResponse {
	/// Object of settings for the input
	Map<String, dynamic> get inputSettings => data["inputSettings"];

	/// The kind of the input
	String get inputKind => data["inputKind"];

	GetInputSettingsResponse(data, status) : super(data, status);
	GetInputSettingsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputMuteResponse extends RequestResponse {
	/// Whether the input is muted
	bool get inputMuted => data["inputMuted"];

	GetInputMuteResponse(data, status) : super(data, status);
	GetInputMuteResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class ToggleInputMuteResponse extends RequestResponse {
	/// Whether the input has been muted or unmuted
	bool get inputMuted => data["inputMuted"];

	ToggleInputMuteResponse(data, status) : super(data, status);
	ToggleInputMuteResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputVolumeResponse extends RequestResponse {
	/// Volume setting in mul
	num get inputVolumeMul => data["inputVolumeMul"];

	/// Volume setting in dB
	num get inputVolumeDb => data["inputVolumeDb"];

	GetInputVolumeResponse(data, status) : super(data, status);
	GetInputVolumeResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputAudioBalanceResponse extends RequestResponse {
	/// Audio balance value from 0.0-1.0
	num get inputAudioBalance => data["inputAudioBalance"];

	GetInputAudioBalanceResponse(data, status) : super(data, status);
	GetInputAudioBalanceResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputAudioSyncOffsetResponse extends RequestResponse {
	/// Audio sync offset in milliseconds
	num get inputAudioSyncOffset => data["inputAudioSyncOffset"];

	GetInputAudioSyncOffsetResponse(data, status) : super(data, status);
	GetInputAudioSyncOffsetResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputAudioMonitorTypeResponse extends RequestResponse {
	/// Audio monitor type
	String get monitorType => data["monitorType"];

	GetInputAudioMonitorTypeResponse(data, status) : super(data, status);
	GetInputAudioMonitorTypeResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputAudioTracksResponse extends RequestResponse {
	/// Object of audio tracks and associated enable states
	Map<String, dynamic> get inputAudioTracks => data["inputAudioTracks"];

	GetInputAudioTracksResponse(data, status) : super(data, status);
	GetInputAudioTracksResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetInputPropertiesListPropertyItemsResponse extends RequestResponse {
	/// Array of items in the list property
	List<Map<String, dynamic>> get propertyItems => data["propertyItems"].cast<Map<String, dynamic>>();

	GetInputPropertiesListPropertyItemsResponse(data, status) : super(data, status);
	GetInputPropertiesListPropertyItemsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetMediaInputStatusResponse extends RequestResponse {
	/// State of the media input
	String get mediaState => data["mediaState"];

	/// Total duration of the playing media in milliseconds. `null` if not playing
	num? get mediaDuration => data["mediaDuration"];

	/// Position of the cursor in milliseconds. `null` if not playing
	num? get mediaCursor => data["mediaCursor"];

	GetMediaInputStatusResponse(data, status) : super(data, status);
	GetMediaInputStatusResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetVirtualCamStatusResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	GetVirtualCamStatusResponse(data, status) : super(data, status);
	GetVirtualCamStatusResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class ToggleVirtualCamResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	ToggleVirtualCamResponse(data, status) : super(data, status);
	ToggleVirtualCamResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetReplayBufferStatusResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	GetReplayBufferStatusResponse(data, status) : super(data, status);
	GetReplayBufferStatusResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class ToggleReplayBufferResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	ToggleReplayBufferResponse(data, status) : super(data, status);
	ToggleReplayBufferResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetLastReplayBufferReplayResponse extends RequestResponse {
	/// File path
	String get savedReplayPath => data["savedReplayPath"];

	GetLastReplayBufferReplayResponse(data, status) : super(data, status);
	GetLastReplayBufferReplayResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetOutputStatusResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	/// Whether the output is reconnecting
	bool get outputReconnecting => data["outputReconnecting"];

	/// Current formatted timecode string for the output
	String get outputTimecode => data["outputTimecode"];

	/// Current duration in milliseconds for the output
	num get outputDuration => data["outputDuration"];

	/// Congestion of the output
	num get outputCongestion => data["outputCongestion"];

	/// Number of bytes sent by the output
	num get outputBytes => data["outputBytes"];

	/// Number of frames skipped by the output's process
	num get outputSkippedFrames => data["outputSkippedFrames"];

	/// Total number of frames delivered by the output's process
	num get outputTotalFrames => data["outputTotalFrames"];

	GetOutputStatusResponse(data, status) : super(data, status);
	GetOutputStatusResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class ToggleOutputResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	ToggleOutputResponse(data, status) : super(data, status);
	ToggleOutputResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetOutputSettingsResponse extends RequestResponse {
	/// Output settings
	Map<String, dynamic> get outputSettings => data["outputSettings"];

	GetOutputSettingsResponse(data, status) : super(data, status);
	GetOutputSettingsResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetRecordStatusResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	/// Whether the output is paused
	bool get ouputPaused => data["ouputPaused"];

	/// Current formatted timecode string for the output
	String get outputTimecode => data["outputTimecode"];

	/// Current duration in milliseconds for the output
	num get outputDuration => data["outputDuration"];

	/// Number of bytes sent by the output
	num get outputBytes => data["outputBytes"];

	GetRecordStatusResponse(data, status) : super(data, status);
	GetRecordStatusResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class StopRecordResponse extends RequestResponse {
	/// File name for the saved recording
	String get outputPath => data["outputPath"];

	StopRecordResponse(data, status) : super(data, status);
	StopRecordResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneItemListResponse extends RequestResponse {
	/// Array of scene items in the scene
	List<Map<String, dynamic>> get sceneItems => data["sceneItems"].cast<Map<String, dynamic>>();

	GetSceneItemListResponse(data, status) : super(data, status);
	GetSceneItemListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetGroupSceneItemListResponse extends RequestResponse {
	/// Array of scene items in the group
	List<Map<String, dynamic>> get sceneItems => data["sceneItems"].cast<Map<String, dynamic>>();

	GetGroupSceneItemListResponse(data, status) : super(data, status);
	GetGroupSceneItemListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneItemIdResponse extends RequestResponse {
	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	GetSceneItemIdResponse(data, status) : super(data, status);
	GetSceneItemIdResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class CreateSceneItemResponse extends RequestResponse {
	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	CreateSceneItemResponse(data, status) : super(data, status);
	CreateSceneItemResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class DuplicateSceneItemResponse extends RequestResponse {
	/// Numeric ID of the duplicated scene item
	num get sceneItemId => data["sceneItemId"];

	DuplicateSceneItemResponse(data, status) : super(data, status);
	DuplicateSceneItemResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneItemTransformResponse extends RequestResponse {
	/// Object containing scene item transform info
	Map<String, dynamic> get sceneItemTransform => data["sceneItemTransform"];

	GetSceneItemTransformResponse(data, status) : super(data, status);
	GetSceneItemTransformResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneItemEnabledResponse extends RequestResponse {
	/// Whether the scene item is enabled. `true` for enabled, `false` for disabled
	bool get sceneItemEnabled => data["sceneItemEnabled"];

	GetSceneItemEnabledResponse(data, status) : super(data, status);
	GetSceneItemEnabledResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneItemLockedResponse extends RequestResponse {
	/// Whether the scene item is locked. `true` for locked, `false` for unlocked
	bool get sceneItemLocked => data["sceneItemLocked"];

	GetSceneItemLockedResponse(data, status) : super(data, status);
	GetSceneItemLockedResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneItemIndexResponse extends RequestResponse {
	/// Index position of the scene item
	num get sceneItemIndex => data["sceneItemIndex"];

	GetSceneItemIndexResponse(data, status) : super(data, status);
	GetSceneItemIndexResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneItemBlendModeResponse extends RequestResponse {
	/// Current blend mode
	String get sceneItemBlendMode => data["sceneItemBlendMode"];

	GetSceneItemBlendModeResponse(data, status) : super(data, status);
	GetSceneItemBlendModeResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneListResponse extends RequestResponse {
	/// Current program scene
	String get currentProgramSceneName => data["currentProgramSceneName"];

	/// Current preview scene. `null` if not in studio mode
	String? get currentPreviewSceneName => data["currentPreviewSceneName"];

	/// Array of scenes
	List<Map<String, dynamic>> get scenes => data["scenes"].cast<Map<String, dynamic>>();

	GetSceneListResponse(data, status) : super(data, status);
	GetSceneListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetGroupListResponse extends RequestResponse {
	/// Array of group names
	List<String> get groups => data["groups"].cast<String>();

	GetGroupListResponse(data, status) : super(data, status);
	GetGroupListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetCurrentProgramSceneResponse extends RequestResponse {
	/// Current program scene
	String get currentProgramSceneName => data["currentProgramSceneName"];

	GetCurrentProgramSceneResponse(data, status) : super(data, status);
	GetCurrentProgramSceneResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetCurrentPreviewSceneResponse extends RequestResponse {
	/// Current preview scene
	String get currentPreviewSceneName => data["currentPreviewSceneName"];

	GetCurrentPreviewSceneResponse(data, status) : super(data, status);
	GetCurrentPreviewSceneResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneSceneTransitionOverrideResponse extends RequestResponse {
	/// Name of the overridden scene transition, else `null`
	String? get transitionName => data["transitionName"];

	/// Duration of the overridden scene transition, else `null`
	num? get transitionDuration => data["transitionDuration"];

	GetSceneSceneTransitionOverrideResponse(data, status) : super(data, status);
	GetSceneSceneTransitionOverrideResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSourceActiveResponse extends RequestResponse {
	/// Whether the source is showing in Program
	bool get videoActive => data["videoActive"];

	/// Whether the source is showing in the UI (Preview, Projector, Properties)
	bool get videoShowing => data["videoShowing"];

	GetSourceActiveResponse(data, status) : super(data, status);
	GetSourceActiveResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSourceScreenshotResponse extends RequestResponse {
	/// Base64-encoded screenshot
	String get imageData => data["imageData"];

	GetSourceScreenshotResponse(data, status) : super(data, status);
	GetSourceScreenshotResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class SaveSourceScreenshotResponse extends RequestResponse {
	/// Base64-encoded screenshot
	String get imageData => data["imageData"];

	SaveSourceScreenshotResponse(data, status) : super(data, status);
	SaveSourceScreenshotResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetStreamStatusResponse extends RequestResponse {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	/// Whether the output is currently reconnecting
	bool get outputReconnecting => data["outputReconnecting"];

	/// Current formatted timecode string for the output
	String get outputTimecode => data["outputTimecode"];

	/// Current duration in milliseconds for the output
	num get outputDuration => data["outputDuration"];

	/// Congestion of the output
	num get outputCongestion => data["outputCongestion"];

	/// Number of bytes sent by the output
	num get outputBytes => data["outputBytes"];

	/// Number of frames skipped by the output's process
	num get outputSkippedFrames => data["outputSkippedFrames"];

	/// Total number of frames delivered by the output's process
	num get outputTotalFrames => data["outputTotalFrames"];

	GetStreamStatusResponse(data, status) : super(data, status);
	GetStreamStatusResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class ToggleStreamResponse extends RequestResponse {
	/// New state of the stream output
	bool get outputActive => data["outputActive"];

	ToggleStreamResponse(data, status) : super(data, status);
	ToggleStreamResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetTransitionKindListResponse extends RequestResponse {
	/// Array of transition kinds
	List<String> get transitionKinds => data["transitionKinds"].cast<String>();

	GetTransitionKindListResponse(data, status) : super(data, status);
	GetTransitionKindListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetSceneTransitionListResponse extends RequestResponse {
	/// Name of the current scene transition. Can be null
	String? get currentSceneTransitionName => data["currentSceneTransitionName"];

	/// Kind of the current scene transition. Can be null
	String? get currentSceneTransitionKind => data["currentSceneTransitionKind"];

	/// Array of transitions
	List<Map<String, dynamic>> get transitions => data["transitions"].cast<Map<String, dynamic>>();

	GetSceneTransitionListResponse(data, status) : super(data, status);
	GetSceneTransitionListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetCurrentSceneTransitionResponse extends RequestResponse {
	/// Name of the transition
	String get transitionName => data["transitionName"];

	/// Kind of the transition
	String get transitionKind => data["transitionKind"];

	/// Whether the transition uses a fixed (unconfigurable) duration
	bool get transitionFixed => data["transitionFixed"];

	/// Configured transition duration in milliseconds. `null` if transition is fixed
	num? get transitionDuration => data["transitionDuration"];

	/// Whether the transition supports being configured
	bool get transitionConfigurable => data["transitionConfigurable"];

	/// Object of settings for the transition. `null` if transition is not configurable
	Map<String, dynamic>? get transitionSettings => data["transitionSettings"];

	GetCurrentSceneTransitionResponse(data, status) : super(data, status);
	GetCurrentSceneTransitionResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetCurrentSceneTransitionCursorResponse extends RequestResponse {
	/// Cursor position, between 0.0 and 1.0
	num get transitionCursor => data["transitionCursor"];

	GetCurrentSceneTransitionCursorResponse(data, status) : super(data, status);
	GetCurrentSceneTransitionCursorResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetStudioModeEnabledResponse extends RequestResponse {
	/// Whether studio mode is enabled
	bool get studioModeEnabled => data["studioModeEnabled"];

	GetStudioModeEnabledResponse(data, status) : super(data, status);
	GetStudioModeEnabledResponse.fromResponse(resp) : this(resp.data, resp.status);
}

class GetMonitorListResponse extends RequestResponse {
	/// a list of detected monitors with some information
	List<Map<String, dynamic>> get monitors => data["monitors"].cast<Map<String, dynamic>>();

	GetMonitorListResponse(data, status) : super(data, status);
	GetMonitorListResponse.fromResponse(resp) : this(resp.data, resp.status);
}

