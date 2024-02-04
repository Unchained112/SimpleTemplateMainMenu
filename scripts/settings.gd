extends TabContainer

@export var pre_scene: Node

@onready var video: TabBar = $Video
@onready var audio: TabBar = $Audio

func _ready():
	reload_settings()
	hide()

func reset_focus():
	if current_tab == 0: # Video
		$Video.grab_focus()
	elif current_tab == 1: # Audio
		$Audio.grab_focus()
	elif current_tab == 2: # Controls
		$Controls.grab_focus()

func reload_settings():
	video.load_video_settings()
	audio.load_audio_settings()

func _on_back_pressed():
	hide()
	pre_scene.reset_focus()
	AudioManager.play_button_sound()
