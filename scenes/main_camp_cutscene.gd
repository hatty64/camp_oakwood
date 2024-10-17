extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	animation_player.play("squirrel_running")
	await animation_player.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/ep_1_cutscenes.dialogue"), "Start_cookie_steal_1")
	await DialogueManager.dialogue_ended
	animation_player.play("maysie_turn_to_christina")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/ep_1_cutscenes.dialogue"), "Start_cookie_steal_2")
	await DialogueManager.dialogue_ended
	animation_player.play("maysie_walk_back")
	await animation_player.animation_finished
	await get_tree().create_timer(2.0).timeout
	Global.loadin_world2 = true
	GlobalDays.ep1_day1_cutscene1 = false
	Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
