extends Node


@onready var christina_anim = $christina/AnimationPlayer
@onready var camera_anim = $Camera2D/AnimationPlayer
@onready var exclamation = $damian/exclamation
@onready var jacob_anim = $jacob/AnimationPlayer
@onready var dinah_anim = $dinah/AnimationPlayer
@onready var maya_anim = $maya/AnimationPlayer
@onready var damian_anim = $damian/AnimationPlayer


func _ready() -> void:
	BirdSound.stop()
	await get_tree().create_timer(3.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(3.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_2")
	await DialogueManager.dialogue_ended
	christina_anim.speed_scale = 0.5
	camera_anim.speed_scale = 0.5
	christina_anim.play("move_up")
	camera_anim.play("move_down")
	await christina_anim.animation_finished
	exclamation.show()
	await get_tree().create_timer(1.0).timeout
	exclamation.hide()
	await get_tree().create_timer(0.5).timeout
	jacob_anim.play("look_down")
	maya_anim.play("look_down")
	dinah_anim.play("look_down")
	await  dinah_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_3")
	await DialogueManager.dialogue_ended
	jacob_anim.speed_scale = 1.5
	jacob_anim.play("move_down")
	await jacob_anim.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_4")
	await DialogueManager.dialogue_ended
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_5")
	damian_anim.play("move_down")
	await damian_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	jacob_anim.speed_scale = 1.0
	jacob_anim.play("move_back")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_6")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2.0).timeout
	damian_anim.play("turn_left")
	await damian_anim.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_7")
	await DialogueManager.dialogue_ended
	jacob_anim.play("turn_right")
	await jacob_anim.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_8")
	await DialogueManager.dialogue_ended
	damian_anim.play("turn_down")
	await damian_anim.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_9")
	await DialogueManager.dialogue_ended
	damian_anim.play("move_up")
	await damian_anim.animation_finished
	jacob_anim.play("move_right")
	await jacob_anim.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_10")
	await DialogueManager.dialogue_ended
	jacob_anim.play("move_up")
	await jacob_anim.animation_finished
	camera_anim.play("move_to_christina")
	await camera_anim.animation_finished
	Transit.change_scene_to_file("res://scenes/dining_area.tscn")
