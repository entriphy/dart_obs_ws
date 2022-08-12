import '../classes/event.dart';

/// The current scene collection has begun changing.
/// 
/// Note: We recommend using this event to trigger a pause of all polling requests, as performing any requests during a
/// scene collection change is considered undefined behavior and can cause crashes!
/// * Subscription: Config
/// * Category: Config
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentSceneCollectionChanging extends Event {
	/// Name of the current scene collection
	String get sceneCollectionName => data["sceneCollectionName"];

	CurrentSceneCollectionChanging(super.data);
}

/// The current scene collection has changed.
/// 
/// Note: If polling has been paused during `CurrentSceneCollectionChanging`, this is the que to restart polling.
/// * Subscription: Config
/// * Category: Config
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentSceneCollectionChanged extends Event {
	/// Name of the new scene collection
	String get sceneCollectionName => data["sceneCollectionName"];

	CurrentSceneCollectionChanged(super.data);
}

/// The scene collection list has changed.
/// * Subscription: Config
/// * Category: Config
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneCollectionListChanged extends Event {
	/// Updated list of scene collections
	List<String> get sceneCollections => data["sceneCollections"].cast<String>();

	SceneCollectionListChanged(super.data);
}

/// The current profile has begun changing.
/// * Subscription: Config
/// * Category: Config
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentProfileChanging extends Event {
	/// Name of the current profile
	String get profileName => data["profileName"];

	CurrentProfileChanging(super.data);
}

/// The current profile has changed.
/// * Subscription: Config
/// * Category: Config
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentProfileChanged extends Event {
	/// Name of the new profile
	String get profileName => data["profileName"];

	CurrentProfileChanged(super.data);
}

/// The profile list has changed.
/// * Subscription: Config
/// * Category: Config
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class ProfileListChanged extends Event {
	/// Updated list of profiles
	List<String> get profiles => data["profiles"].cast<String>();

	ProfileListChanged(super.data);
}

/// A source's filter list has been reindexed.
/// * Subscription: Filters
/// * Category: Filters
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SourceFilterListReindexed extends Event {
	/// Name of the source
	String get sourceName => data["sourceName"];

	/// Array of filter objects
	List<Map<String, dynamic>> get filters => data["filters"].cast<Map<String, dynamic>>();

	SourceFilterListReindexed(super.data);
}

/// A filter has been added to a source.
/// * Subscription: Filters
/// * Category: Filters
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SourceFilterCreated extends Event {
	/// Name of the source the filter was added to
	String get sourceName => data["sourceName"];

	/// Name of the filter
	String get filterName => data["filterName"];

	/// The kind of the filter
	String get filterKind => data["filterKind"];

	/// Index position of the filter
	num get filterIndex => data["filterIndex"];

	/// The settings configured to the filter when it was created
	Map<String, dynamic> get filterSettings => data["filterSettings"];

	/// The default settings for the filter
	Map<String, dynamic> get defaultFilterSettings => data["defaultFilterSettings"];

	SourceFilterCreated(super.data);
}

/// A filter has been removed from a source.
/// * Subscription: Filters
/// * Category: Filters
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SourceFilterRemoved extends Event {
	/// Name of the source the filter was on
	String get sourceName => data["sourceName"];

	/// Name of the filter
	String get filterName => data["filterName"];

	SourceFilterRemoved(super.data);
}

/// The name of a source filter has changed.
/// * Subscription: Filters
/// * Category: Filters
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SourceFilterNameChanged extends Event {
	/// The source the filter is on
	String get sourceName => data["sourceName"];

	/// Old name of the filter
	String get oldFilterName => data["oldFilterName"];

	/// New name of the filter
	String get filterName => data["filterName"];

	SourceFilterNameChanged(super.data);
}

/// A source filter's enable state has changed.
/// * Subscription: Filters
/// * Category: Filters
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SourceFilterEnableStateChanged extends Event {
	/// Name of the source the filter is on
	String get sourceName => data["sourceName"];

	/// Name of the filter
	String get filterName => data["filterName"];

	/// Whether the filter is enabled
	bool get filterEnabled => data["filterEnabled"];

	SourceFilterEnableStateChanged(super.data);
}

/// OBS has begun the shutdown process.
/// * Subscription: General
/// * Category: General
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class ExitStarted extends Event {
	ExitStarted(super.data);
}

/// An input has been created.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputCreated extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// The kind of the input
	String get inputKind => data["inputKind"];

	/// The unversioned kind of input (aka no `_v2` stuff)
	String get unversionedInputKind => data["unversionedInputKind"];

	/// The settings configured to the input when it was created
	Map<String, dynamic> get inputSettings => data["inputSettings"];

	/// The default settings for the input
	Map<String, dynamic> get defaultInputSettings => data["defaultInputSettings"];

	InputCreated(super.data);
}

/// An input has been removed.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputRemoved extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	InputRemoved(super.data);
}

/// The name of an input has changed.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputNameChanged extends Event {
	/// Old name of the input
	String get oldInputName => data["oldInputName"];

	/// New name of the input
	String get inputName => data["inputName"];

	InputNameChanged(super.data);
}

/// An input's active state has changed.
/// 
/// When an input is active, it means it's being shown by the program feed.
/// * Subscription: InputActiveStateChanged
/// * Category: Inputs
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputActiveStateChanged extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// Whether the input is active
	bool get videoActive => data["videoActive"];

	InputActiveStateChanged(super.data);
}

/// An input's show state has changed.
/// 
/// When an input is showing, it means it's being shown by the preview or a dialog.
/// * Subscription: InputShowStateChanged
/// * Category: Inputs
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputShowStateChanged extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// Whether the input is showing
	bool get videoShowing => data["videoShowing"];

	InputShowStateChanged(super.data);
}

/// An input's mute state has changed.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputMuteStateChanged extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// Whether the input is muted
	bool get inputMuted => data["inputMuted"];

	InputMuteStateChanged(super.data);
}

/// An input's volume level has changed.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputVolumeChanged extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// New volume level in multimap
	num get inputVolumeMul => data["inputVolumeMul"];

	/// New volume level in dB
	num get inputVolumeDb => data["inputVolumeDb"];

	InputVolumeChanged(super.data);
}

/// The audio balance value of an input has changed.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputAudioBalanceChanged extends Event {
	/// Name of the affected input
	String get inputName => data["inputName"];

	/// New audio balance value of the input
	num get inputAudioBalance => data["inputAudioBalance"];

	InputAudioBalanceChanged(super.data);
}

/// The sync offset of an input has changed.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputAudioSyncOffsetChanged extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// New sync offset in milliseconds
	num get inputAudioSyncOffset => data["inputAudioSyncOffset"];

	InputAudioSyncOffsetChanged(super.data);
}

/// The audio tracks of an input have changed.
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputAudioTracksChanged extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// Object of audio tracks along with their associated enable states
	Map<String, dynamic> get inputAudioTracks => data["inputAudioTracks"];

	InputAudioTracksChanged(super.data);
}

/// The monitor type of an input has changed.
/// 
/// Available types are:
/// 
/// - `OBS_MONITORING_TYPE_NONE`
/// - `OBS_MONITORING_TYPE_MONITOR_ONLY`
/// - `OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT`
/// * Subscription: Inputs
/// * Category: Inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputAudioMonitorTypeChanged extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// New monitor type of the input
	String get monitorType => data["monitorType"];

	InputAudioMonitorTypeChanged(super.data);
}

/// A high-volume event providing volume levels of all active inputs every 50 milliseconds.
/// * Subscription: InputVolumeMeters
/// * Category: Inputs
/// * Complexity: 4/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class InputVolumeMeters extends Event {
	/// Array of active inputs with their associated volume levels
	List<Map<String, dynamic>> get inputs => data["inputs"].cast<Map<String, dynamic>>();

	InputVolumeMeters(super.data);
}

/// A media input has started playing.
/// * Subscription: MediaInputs
/// * Category: Media inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class MediaInputPlaybackStarted extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	MediaInputPlaybackStarted(super.data);
}

/// A media input has finished playing.
/// * Subscription: MediaInputs
/// * Category: Media inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class MediaInputPlaybackEnded extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	MediaInputPlaybackEnded(super.data);
}

/// An action has been performed on an input.
/// * Subscription: MediaInputs
/// * Category: Media inputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class MediaInputActionTriggered extends Event {
	/// Name of the input
	String get inputName => data["inputName"];

	/// Action performed on the input. See `ObsMediaInputAction` enum
	String get mediaAction => data["mediaAction"];

	MediaInputActionTriggered(super.data);
}

/// The state of the stream output has changed.
/// * Subscription: Outputs
/// * Category: Outputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class StreamStateChanged extends Event {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	/// The specific state of the output
	String get outputState => data["outputState"];

	StreamStateChanged(super.data);
}

/// The state of the record output has changed.
/// * Subscription: Outputs
/// * Category: Outputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class RecordStateChanged extends Event {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	/// The specific state of the output
	String get outputState => data["outputState"];

	/// File name for the saved recording, if record stopped. `null` otherwise
	String get outputPath => data["outputPath"];

	RecordStateChanged(super.data);
}

/// The state of the replay buffer output has changed.
/// * Subscription: Outputs
/// * Category: Outputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class ReplayBufferStateChanged extends Event {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	/// The specific state of the output
	String get outputState => data["outputState"];

	ReplayBufferStateChanged(super.data);
}

/// The state of the virtualcam output has changed.
/// * Subscription: Outputs
/// * Category: Outputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class VirtualcamStateChanged extends Event {
	/// Whether the output is active
	bool get outputActive => data["outputActive"];

	/// The specific state of the output
	String get outputState => data["outputState"];

	VirtualcamStateChanged(super.data);
}

/// The replay buffer has been saved.
/// * Subscription: Outputs
/// * Category: Outputs
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class ReplayBufferSaved extends Event {
	/// Path of the saved replay file
	String get savedReplayPath => data["savedReplayPath"];

	ReplayBufferSaved(super.data);
}

/// A scene item has been created.
/// * Subscription: SceneItems
/// * Category: Scene items
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneItemCreated extends Event {
	/// Name of the scene the item was added to
	String get sceneName => data["sceneName"];

	/// Name of the underlying source (input/scene)
	String get sourceName => data["sourceName"];

	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	/// Index position of the item
	num get sceneItemIndex => data["sceneItemIndex"];

	SceneItemCreated(super.data);
}

/// A scene item has been removed.
/// 
/// This event is not emitted when the scene the item is in is removed.
/// * Subscription: SceneItems
/// * Category: Scene items
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneItemRemoved extends Event {
	/// Name of the scene the item was removed from
	String get sceneName => data["sceneName"];

	/// Name of the underlying source (input/scene)
	String get sourceName => data["sourceName"];

	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	SceneItemRemoved(super.data);
}

/// A scene's item list has been reindexed.
/// * Subscription: SceneItems
/// * Category: Scene items
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneItemListReindexed extends Event {
	/// Name of the scene
	String get sceneName => data["sceneName"];

	/// Array of scene item objects
	List<Map<String, dynamic>> get sceneItems => data["sceneItems"].cast<Map<String, dynamic>>();

	SceneItemListReindexed(super.data);
}

/// A scene item's enable state has changed.
/// * Subscription: SceneItems
/// * Category: Scene items
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneItemEnableStateChanged extends Event {
	/// Name of the scene the item is in
	String get sceneName => data["sceneName"];

	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	/// Whether the scene item is enabled (visible)
	bool get sceneItemEnabled => data["sceneItemEnabled"];

	SceneItemEnableStateChanged(super.data);
}

/// A scene item's lock state has changed.
/// * Subscription: SceneItems
/// * Category: Scene items
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneItemLockStateChanged extends Event {
	/// Name of the scene the item is in
	String get sceneName => data["sceneName"];

	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	/// Whether the scene item is locked
	bool get sceneItemLocked => data["sceneItemLocked"];

	SceneItemLockStateChanged(super.data);
}

/// A scene item has been selected in the Ui.
/// * Subscription: SceneItems
/// * Category: Scene items
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneItemSelected extends Event {
	/// Name of the scene the item is in
	String get sceneName => data["sceneName"];

	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	SceneItemSelected(super.data);
}

/// The transform/crop of a scene item has changed.
/// * Subscription: SceneItemTransformChanged
/// * Category: Scene items
/// * Complexity: 4/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneItemTransformChanged extends Event {
	/// The name of the scene the item is in
	String get sceneName => data["sceneName"];

	/// Numeric ID of the scene item
	num get sceneItemId => data["sceneItemId"];

	/// New transform/crop info of the scene item
	Map<String, dynamic> get sceneItemTransform => data["sceneItemTransform"];

	SceneItemTransformChanged(super.data);
}

/// A new scene has been created.
/// * Subscription: Scenes
/// * Category: Scenes
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneCreated extends Event {
	/// Name of the new scene
	String get sceneName => data["sceneName"];

	/// Whether the new scene is a group
	bool get isGroup => data["isGroup"];

	SceneCreated(super.data);
}

/// A scene has been removed.
/// * Subscription: Scenes
/// * Category: Scenes
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneRemoved extends Event {
	/// Name of the removed scene
	String get sceneName => data["sceneName"];

	/// Whether the scene was a group
	bool get isGroup => data["isGroup"];

	SceneRemoved(super.data);
}

/// The name of a scene has changed.
/// * Subscription: Scenes
/// * Category: Scenes
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneNameChanged extends Event {
	/// Old name of the scene
	String get oldSceneName => data["oldSceneName"];

	/// New name of the scene
	String get sceneName => data["sceneName"];

	SceneNameChanged(super.data);
}

/// The current program scene has changed.
/// * Subscription: Scenes
/// * Category: Scenes
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentProgramSceneChanged extends Event {
	/// Name of the scene that was switched to
	String get sceneName => data["sceneName"];

	CurrentProgramSceneChanged(super.data);
}

/// The current preview scene has changed.
/// * Subscription: Scenes
/// * Category: Scenes
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentPreviewSceneChanged extends Event {
	/// Name of the scene that was switched to
	String get sceneName => data["sceneName"];

	CurrentPreviewSceneChanged(super.data);
}

/// The list of scenes has changed.
/// 
/// TODO: Make OBS fire this event when scenes are reordered.
/// * Subscription: Scenes
/// * Category: Scenes
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneListChanged extends Event {
	/// Updated array of scenes
	List<Map<String, dynamic>> get scenes => data["scenes"].cast<Map<String, dynamic>>();

	SceneListChanged(super.data);
}

/// The current scene transition has changed.
/// * Subscription: Transitions
/// * Category: Transitions
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentSceneTransitionChanged extends Event {
	/// Name of the new transition
	String get transitionName => data["transitionName"];

	CurrentSceneTransitionChanged(super.data);
}

/// The current scene transition duration has changed.
/// * Subscription: Transitions
/// * Category: Transitions
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class CurrentSceneTransitionDurationChanged extends Event {
	/// Transition duration in milliseconds
	num get transitionDuration => data["transitionDuration"];

	CurrentSceneTransitionDurationChanged(super.data);
}

/// A scene transition has started.
/// * Subscription: Transitions
/// * Category: Transitions
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneTransitionStarted extends Event {
	/// Scene transition name
	String get transitionName => data["transitionName"];

	SceneTransitionStarted(super.data);
}

/// A scene transition has completed fully.
/// 
/// Note: Does not appear to trigger when the transition is interrupted by the user.
/// * Subscription: Transitions
/// * Category: Transitions
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneTransitionEnded extends Event {
	/// Scene transition name
	String get transitionName => data["transitionName"];

	SceneTransitionEnded(super.data);
}

/// A scene transition's video has completed fully.
/// 
/// Useful for stinger transitions to tell when the video *actually* ends.
/// `SceneTransitionEnded` only signifies the cut point, not the completion of transition playback.
/// 
/// Note: Appears to be called by every transition, regardless of relevance.
/// * Subscription: Transitions
/// * Category: Transitions
/// * Complexity: 2/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class SceneTransitionVideoEnded extends Event {
	/// Scene transition name
	String get transitionName => data["transitionName"];

	SceneTransitionVideoEnded(super.data);
}

/// Studio mode has been enabled or disabled.
/// * Subscription: Ui
/// * Category: Ui
/// * Complexity: 1/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class StudioModeStateChanged extends Event {
	/// True == Enabled, False == Disabled
	bool get studioModeEnabled => data["studioModeEnabled"];

	StudioModeStateChanged(super.data);
}

/// An event has been emitted from a vendor.
/// 
/// A vendor is a unique name registered by a third-party plugin or script, which allows for custom requests and events to be added to obs-websocket.
/// If a plugin or script implements vendor requests or events, documentation is expected to be provided with them.
/// * Subscription: Vendors
/// * Category: General
/// * Complexity: 3/5
/// * RPC Version: 1
/// * Initial Version: 5.0.0
class VendorEvent extends Event {
	/// Name of the vendor emitting the event
	String get vendorName => data["vendorName"];

	/// Vendor-provided event typedef
	String get eventType => data["eventType"];

	/// Vendor-provided event data. {} if event does not provide any data
	Map<String, dynamic> get eventData => data["eventData"];

	VendorEvent(super.data);
}

const Map<String, Event Function(Map<String, dynamic> data)> EventMap = {
	"CurrentSceneCollectionChanging": CurrentSceneCollectionChanging.new,
	"CurrentSceneCollectionChanged": CurrentSceneCollectionChanged.new,
	"SceneCollectionListChanged": SceneCollectionListChanged.new,
	"CurrentProfileChanging": CurrentProfileChanging.new,
	"CurrentProfileChanged": CurrentProfileChanged.new,
	"ProfileListChanged": ProfileListChanged.new,
	"SourceFilterListReindexed": SourceFilterListReindexed.new,
	"SourceFilterCreated": SourceFilterCreated.new,
	"SourceFilterRemoved": SourceFilterRemoved.new,
	"SourceFilterNameChanged": SourceFilterNameChanged.new,
	"SourceFilterEnableStateChanged": SourceFilterEnableStateChanged.new,
	"ExitStarted": ExitStarted.new,
	"InputCreated": InputCreated.new,
	"InputRemoved": InputRemoved.new,
	"InputNameChanged": InputNameChanged.new,
	"InputActiveStateChanged": InputActiveStateChanged.new,
	"InputShowStateChanged": InputShowStateChanged.new,
	"InputMuteStateChanged": InputMuteStateChanged.new,
	"InputVolumeChanged": InputVolumeChanged.new,
	"InputAudioBalanceChanged": InputAudioBalanceChanged.new,
	"InputAudioSyncOffsetChanged": InputAudioSyncOffsetChanged.new,
	"InputAudioTracksChanged": InputAudioTracksChanged.new,
	"InputAudioMonitorTypeChanged": InputAudioMonitorTypeChanged.new,
	"InputVolumeMeters": InputVolumeMeters.new,
	"MediaInputPlaybackStarted": MediaInputPlaybackStarted.new,
	"MediaInputPlaybackEnded": MediaInputPlaybackEnded.new,
	"MediaInputActionTriggered": MediaInputActionTriggered.new,
	"StreamStateChanged": StreamStateChanged.new,
	"RecordStateChanged": RecordStateChanged.new,
	"ReplayBufferStateChanged": ReplayBufferStateChanged.new,
	"VirtualcamStateChanged": VirtualcamStateChanged.new,
	"ReplayBufferSaved": ReplayBufferSaved.new,
	"SceneItemCreated": SceneItemCreated.new,
	"SceneItemRemoved": SceneItemRemoved.new,
	"SceneItemListReindexed": SceneItemListReindexed.new,
	"SceneItemEnableStateChanged": SceneItemEnableStateChanged.new,
	"SceneItemLockStateChanged": SceneItemLockStateChanged.new,
	"SceneItemSelected": SceneItemSelected.new,
	"SceneItemTransformChanged": SceneItemTransformChanged.new,
	"SceneCreated": SceneCreated.new,
	"SceneRemoved": SceneRemoved.new,
	"SceneNameChanged": SceneNameChanged.new,
	"CurrentProgramSceneChanged": CurrentProgramSceneChanged.new,
	"CurrentPreviewSceneChanged": CurrentPreviewSceneChanged.new,
	"SceneListChanged": SceneListChanged.new,
	"CurrentSceneTransitionChanged": CurrentSceneTransitionChanged.new,
	"CurrentSceneTransitionDurationChanged": CurrentSceneTransitionDurationChanged.new,
	"SceneTransitionStarted": SceneTransitionStarted.new,
	"SceneTransitionEnded": SceneTransitionEnded.new,
	"SceneTransitionVideoEnded": SceneTransitionVideoEnded.new,
	"StudioModeStateChanged": StudioModeStateChanged.new,
	"VendorEvent": VendorEvent.new,
};

