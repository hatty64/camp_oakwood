extends Node2D

@onready var awake := $christina_awake/AnimationPlayer
@onready var barley_anim := $barley/AnimationPlayer
@onready var barley := $barley
@onready var exclamation := $barley/exclamation
@onready var screen := $screen/AnimationPlayer
@onready var ester_anim = $ester/AnimationPlayer
@onready var ester = $ester
@onready var exclamation_ester = $ester/exclamation

var skipped = false

func _on_ready():
	add_child($Timer)
	awake.play("awake")
	await awake.animation_finished
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	barley.show()
	barley_anim.play("move_up")
	await barley_anim.animation_finished
	exclamation.show()
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	exclamation.hide()
	awake.play("look_down")
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start")
		await DialogueManager.dialogue_ended
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_2")
		await DialogueManager.dialogue_ended
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_3")
		await DialogueManager.dialogue_ended
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_4")
		await DialogueManager.dialogue_ended
	barley_anim.play("move_down")
	await barley_anim.animation_finished
	barley.hide()
	barley_anim.play("RESET")
	await barley_anim.animation_finished
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	awake.play("look_left")
	screen.play("fade_in_out")
	await screen.animation_finished
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Card")
		await DialogueManager.dialogue_ended
	screen.play_backwards("fade_in_out")
	await screen.animation_finished
	$Timer.wait_time = 2
	$Timer.start()
	await $Timer.timeout
	barley.show()
	barley_anim.play("move_up")
	await barley_anim.animation_finished
	awake.play("look_down")
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_5")
		await DialogueManager.dialogue_ended
	barley_anim.play("move_left_up")
	await barley_anim.animation_finished
	awake.play("look_left")
	ester.show()
	ester_anim.play("move_up")
	await ester_anim.animation_finished
	awake.play("look_down")
	exclamation_ester.show()
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	exclamation_ester.hide()
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_6")
		await DialogueManager.dialogue_ended
	ester_anim.play("look_left")
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_7")
		await DialogueManager.dialogue_ended
	ester_anim.play("move_down")
	await ester_anim.animation_finished
	ester.hide()
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	barley_anim.play("move_right")
	await barley_anim.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_8")
		await DialogueManager.dialogue_ended
	barley_anim.play("move_down")
	await barley_anim.animation_finished
	barley.hide()
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	awake.play("get_up")
	await awake.animation_finished
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	Transit.change_scene_to_file("res://scenes/tent.tscn")


func _process(delta: float) -> void:
	hold_to_skip()

func hold_to_skip():
	if $CanvasLayer2/hold_skip/ProgressBar.value == $CanvasLayer2/hold_skip/ProgressBar.max_value:
		skipped = true
		Transit.change_scene_to_file("res://scenes/tent.tscn")
