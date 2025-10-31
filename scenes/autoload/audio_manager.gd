extends Node

@export_category("Audio Files")
@export var audio_library: Dictionary = {
	# SFX - Single files
	"player_shoot":[preload("uid://cyk2cxbhsdq83"),preload("uid://naa3jurmk4dt"), preload("uid://bauypbnn27pfb")],
	"player_walk":[preload("uid://jdod6qk2txbp"), preload("uid://cfn2khpf20cj6"), preload("uid://bj286fq45ptc1"), preload("uid://c0mcj4qx0trch")],
	"player_damaged":[preload("uid://bhd7pvu3hqw2i"), preload("uid://c15ioorahaeoj"), preload("uid://b3fpiw1v2ht2g")],
	"room_cleared":preload("uid://cqmcnje02vusm"),
	"enemy_explosion": preload("uid://mc8mdkqh4206"),
	"enemy_death": preload("uid://dag633uflhmup"),
	"item_abandoned": preload("uid://drhsrtkqyit7j"),
	"bullet_impact": [preload("uid://bnn0w1i261eol"), preload("uid://djcm6i3gmgdaa"), preload("uid://wg6t1tnp066i")],
	# SFX - Arrays (multiple variations)
	"enemy_damaged": [preload("uid://d4yrul84r8n1"), preload("uid://d3etk8hgpmymf"), preload("uid://dj2wbiixtkxsf")],
	"enemy_shooting":[preload("uid://cua4p6622lg3v"), preload("uid://bjhu1ot5ogebh"), preload("uid://bxre80r2yg5s")],
	"enemy_spawn":[preload("uid://cklxh7jiw2fg6"), preload("uid://kjcimooojgrq")],
	"kitsugiried":preload("uid://dvy6anrie5k7y"),
	"player_died":[preload("uid://fiyumv3p5far"), preload("uid://cj0yv680dtpm2")],
}

@export_category("Music")
@export var music_library: Dictionary = {
	"forest": null,
}

@onready var current_music: AudioStreamPlayer = %CurrentMusic

@export var crossfade_time := 0.1

func _ready():
	pass

func play(sound: String, sound_bus: String = "sfx"):
	if sound_bus == "sfx":
		var audio_player := AudioStreamPlayer.new()
		add_child(audio_player)
		audio_player.stream = _fetch_audio(sound)
		#audio_player.bus = sound_bus
		audio_player.play(0.0)
		audio_player.pitch_scale += randf_range(-0.05, 0.05)
		await audio_player.finished
		audio_player.queue_free()
	elif sound_bus == "music":
		current_music.stream = _fetch_audio(sound, true)
		fade_in()

func _fetch_audio(sound: String, is_music: bool = false) -> AudioStream:
	var library = music_library if is_music else audio_library
	var audio = library.get(sound)
	
	if audio is Array:
		return audio.pick_random() if not audio.is_empty() else null
	return audio

func fade_in(duration: float = 0.5):
	current_music.volume_db = -40
	current_music.play()
	var tween = create_tween()
	tween.tween_property(current_music, "volume_db", 0, duration)

func fade_out(duration: float = 3.0):
	var tween = create_tween()
	tween.tween_property(current_music, "volume_db", -80, duration)
	await tween.finished
	current_music.stop()


func _on_game_started():
	pass

func _on_game_ended():
	current_music.stop()
