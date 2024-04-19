extends Node
var num_effect_players = 64
var available: Array = []  # The available players.
var queue: Array = []  # The queue of sounds to play.

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var sound_player: AudioStreamPlayer = $SoundPlayer

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_effect_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = "Sound Effect"

func play(sound_path):
	# Not to queue too many sounds in a short time interval
	if len(queue) <= num_effect_players:
		queue.append(sound_path)

func _process(_delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()

func play_button_sound():
	sound_player.play()

func play_music_sound():
	music_player.play()

func stop_music():
	music_player.stop()

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)
