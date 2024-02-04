extends Control

@onready var option_menu: TabContainer = $"../Settings"

func _ready():
	$VBoxContainer/Start.grab_focus()

func reset_focus():
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed():
	Utilities.switch_scene("SampleGame", self)
	AudioManager.play_music_sound()

func _on_option_pressed():
	option_menu.show()
	option_menu.reset_focus()
	AudioManager.play_button_sound()

func _on_quit_pressed():
	get_tree().quit()
