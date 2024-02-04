extends Button
class_name RemapButton

@export var action: String = "Up"

func _init():
	toggle_mode = true

func _ready():
	set_process_unhandled_input(false)
	display_key()

func _toggled(_button_pressed):
	set_process_unhandled_input(_button_pressed)
	if _button_pressed:
		text = "press any key"
		release_focus()
	else:
		display_key()
		grab_focus()

func _unhandled_input(event):
	if event.pressed:
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		button_pressed = false
		Utilities.config.set_value("Controls", action, event)
		Utilities.save_data()

func display_key():
	text = InputMap.action_get_events(action)[0].as_text()
