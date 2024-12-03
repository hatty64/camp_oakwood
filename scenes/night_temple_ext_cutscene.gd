extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var casper_anim: AnimationPlayer = $casper/casper_anim

func _ready() -> void:
	$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	MusicPlayer.stop()
	casper_anim.play("reading")
	await get_tree().create_timer(1.0).timeout
	animation_player.play("christina_move_up")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_ext_cutscene.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	animation_player.play("look_up")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_ext_cutscene.dialogue"), "Start_2")
	await DialogueManager.dialogue_ended
	Transit.change_scene_to_file("res://scenes/night_temple_ext.tscn")
