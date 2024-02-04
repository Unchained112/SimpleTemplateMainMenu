extends TabBar

@onready var fullscreen: CheckBox = $HBoxContainer/VBoxContainer2/Fullscreen
@onready var borderless: CheckBox = $HBoxContainer/VBoxContainer2/Borderless
@onready var vsync: OptionButton = $HBoxContainer/VBoxContainer2/Vsync

func _ready():
	load_video_settings()

func load_video_settings():
	var screen_type = Utilities.config.get_value("Video", "fullscreen")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen.button_pressed = true
	var borderless_type = Utilities.config.get_value("Video", "borderless")
	if borderless_type == true:
		borderless.button_pressed = true
	var vsync_index = Utilities.config.get_value("Video", "vsync")
	vsync.selected = vsync_index

func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Utilities.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Utilities.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	Utilities.save_data()
	AudioManager.play_button_sound()

func _on_borderless_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	Utilities.config.set_value("Video", "borderless", toggled_on)
	Utilities.save_data()
	AudioManager.play_button_sound()

func _on_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	Utilities.config.set_value("Video", "vsync", index)
	Utilities.save_data()
	AudioManager.play_button_sound()
