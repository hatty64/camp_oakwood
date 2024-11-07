extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	audio_stream_player.play()
	animation_player.play("chapter1")
	await animation_player.animation_finished
	GlobalDays.ep_one_day_one = true
	await get_tree().create_timer(3.0).timeout
	animation_player.play("fade_black")
	await animation_player.animation_finished
	GlobalDays.ep_one_day_one = true
	GlobalDialogue.sleepable = false
	GlobalDays.woke_up = true
	Global.loadin_world2 = false
	Global.sunset = false
	Global.rain = false
	GlobalDays.ep1_day1_cutscene1 = true
	GlobalDays.start_transit = false
	Transit.change_scene_to_file("res://scenes/cabin_int_female.tscn")
