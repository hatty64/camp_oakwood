extends Node2D

@onready var clancy = $clancy
@onready var clancy_anim := $clancy/AnimationPlayer
@onready var exclamation = $clancy/exclamation
@onready var camera_anim := $Camera2D/AnimationPlayer


func _ready():
	Global.game_first_loadin = false
	BirdSound.play()
	BirdSound.play_music_level()
	await get_tree().create_timer(3.0).timeout
	camera_anim.speed_scale = 0.5
	clancy_anim.speed_scale = 0.5
	camera_anim.play("pan_down")
	clancy_anim.play("move_up")
	await clancy_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	exclamation.show()
	await get_tree().create_timer(1.0).timeout
	exclamation.hide()
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_ext_dialogue.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	clancy_anim.speed_scale = 1.0
	clancy_anim.play("move_down")
	camera_anim.play_backwards("pan_down")
	await camera_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	Transit.change_scene_to_file("res://scenes/tent_ext.tscn")
	BirdSound.stop()
