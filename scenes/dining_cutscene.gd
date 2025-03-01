extends Node2D

@onready var christina_anim := $christina/AnimationPlayer
@onready var camera_anim := $Camera2D/AnimationPlayer
@onready var exclamation = $damian/exclamation
@onready var jacob_anim := $jacob/AnimationPlayer
@onready var dinah_anim := $dinah/AnimationPlayer
@onready var maya_anim := $maya/AnimationPlayer
@onready var damian_anim := $damian/AnimationPlayer

var skipped = false

func _ready():
	
	$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	BGSPlayer.stop()
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start")
		await DialogueManager.dialogue_ended
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_2")
		await DialogueManager.dialogue_ended
	christina_anim.speed_scale = 0.5
	camera_anim.speed_scale = 0.5
	christina_anim.play("move_up")
	camera_anim.play("move_down")
	await christina_anim.animation_finished
	exclamation.show()
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	exclamation.hide()
	$Timer.wait_time = 0.5
	$Timer.start()
	await $Timer.timeout
	jacob_anim.play("look_down")
	maya_anim.play("look_down")
	dinah_anim.play("look_down")
	await dinah_anim.animation_finished
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_3")
		await DialogueManager.dialogue_ended
	jacob_anim.speed_scale = 1.5
	jacob_anim.play("move_down")
	await jacob_anim.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_4")
		await DialogueManager.dialogue_ended
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_5")
	damian_anim.play("move_down")
	await damian_anim.animation_finished
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	jacob_anim.speed_scale = 1.0
	jacob_anim.play("move_back")
	await DialogueManager.dialogue_ended
	$Timer.wait_time = 2
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_6")
		await DialogueManager.dialogue_ended
	$Timer.wait_time = 2
	$Timer.start()
	await $Timer.timeout
	damian_anim.play("turn_left")
	await damian_anim.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_7")
		await DialogueManager.dialogue_ended
	jacob_anim.play("turn_right")
	await jacob_anim.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_8")
		await DialogueManager.dialogue_ended
	damian_anim.play("turn_down")
	await damian_anim.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_9")
		await DialogueManager.dialogue_ended
	damian_anim.play("move_up")
	await damian_anim.animation_finished
	jacob_anim.play("move_right")
	await jacob_anim.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/dining_dialogue.dialogue"), "Start_10")
		await DialogueManager.dialogue_ended
	jacob_anim.play("move_up")
	await jacob_anim.animation_finished
	camera_anim.play("move_to_christina")
	await camera_anim.animation_finished
	Transit.change_scene_to_file("res://scenes/dining_area.tscn")



func _process(delta: float) -> void:
	hold_to_skip()

func hold_to_skip():
	if $CanvasLayer2/hold_skip/ProgressBar.value == $CanvasLayer2/hold_skip/ProgressBar.max_value:
		skipped = true
		#DialogueManager.queue_free()
		Transit.change_scene_to_file("res://scenes/dining_area.tscn")
