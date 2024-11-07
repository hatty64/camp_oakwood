extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	BGSPlayer.stop()
	Global.sunset = true
	await get_tree().create_timer(3.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/barley_office_cutscene.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	animation_player.play("christina_walk_in")
	await animation_player.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/barley_office_cutscene.dialogue"), "Start_2")
	await DialogueManager.dialogue_ended
	animation_player.play("christina_takes_seat")
	await animation_player.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/barley_office_cutscene.dialogue"), "Start_3")
	await DialogueManager.dialogue_ended
	Global.rain = false
	Transit.change_scene_to_file("res://scenes/barley_office_int.tscn")
