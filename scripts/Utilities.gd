extends Node

# Scene manager
@export var scenes: Array[PackedScene] = []
@export var scene_map: Dictionary = {}
@export var is_persistence: bool = false

const PATH = "user://settings.cfg"
var config: ConfigFile

func _ready():
	config = ConfigFile.new()
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			config.set_value("Controls", action, InputMap.action_get_events(action)[0])

	config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("Video", "borderless", false)
	config.set_value("Video", "vsync", DisplayServer.VSYNC_ENABLED)

	for i in range(3):
		config.set_value("Audio", str(i), 0.5)

	if is_persistence:
		load_data()

# Persistence
func save_data():
	if is_persistence:
		config.save(PATH)

func load_data():
	if config.load("user://settings.cfg") != OK:
		save_data()
		return
	load_control_settings()
	load_video_settings()

func load_control_settings():
	var keys = config.get_section_keys("Controls")
	for action in InputMap.get_actions():
		if keys.has(action):
			var value = config.get_value("Controls", action)
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, value)

func load_video_settings():
	var screen_type = config.get_value("Video","fullscreen")
	DisplayServer.window_set_mode(screen_type)
	var borderless = config.get_value("Video","borderless")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderless)
	var vsync_index = config.get_value("Video", "vsync")
	DisplayServer.window_set_vsync_mode(vsync_index)

# Scene manager
func switch_scene(scene_name: StringName, cur_scene: Node):
	var scene = scenes[scene_map[scene_name]].instantiate()
	get_tree().root.add_child(scene)
	cur_scene.queue_free()

func hide_scene(scene):
	scene.hide()

func remove_scene(scene):
	get_tree().root.remove_child(scene)

func delete_scene(scene):
	scene.queue_free()
