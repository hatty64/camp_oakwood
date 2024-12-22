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
	awake.play("awake")
	await awake.animation_finished
	await get_tree().create_timer(3.0).timeout
	barley.show()
	barley_anim.play("move_up")
	await barley_anim.animation_finished
	exclamation.show()
	await get_tree().create_timer(1.0).timeout
	exclamation.hide()
	awake.play("look_down")
	await get_tree().create_timer(1.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start")
		await DialogueManager.dialogue_ended
	await get_tree().create_timer(3.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_2")
		await DialogueManager.dialogue_ended
	await get_tree().create_timer(3.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_3")
		await DialogueManager.dialogue_ended
	await get_tree().create_timer(3.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_4")
		await DialogueManager.dialogue_ended
	barley_anim.play("move_down")
	await barley_anim.animation_finished
	barley.hide()
	barley_anim.play("RESET")
	await barley_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	awake.play("look_left")
	screen.play("fade_in_out")
	await screen.animation_finished
	await get_tree().create_timer(1.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Card")
		await DialogueManager.dialogue_ended
	screen.play_backwards("fade_in_out")
	await screen.animation_finished
	await get_tree().create_timer(2.0).timeout
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
	await get_tree().create_timer(1.0).timeout
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
	await get_tree().create_timer(1.0).timeout
	barley_anim.play("move_right")
	await barley_anim.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_dialogue.dialogue"), "Start_8")
		await DialogueManager.dialogue_ended
	barley_anim.play("move_down")
	await barley_anim.animation_finished
	barley.hide()
	await get_tree().create_timer(3.0).timeout
	awake.play("get_up")
	await awake.animation_finished
	await get_tree().create_timer(1.0).timeout
	Transit.change_scene_to_file("res://scenes/tent.tscn")


func _process(delta: float) -> void:
	hold_to_skip()

func hold_to_skip():
	if $CanvasLayer2/hold_skip/ProgressBar.value == $CanvasLayer2/hold_skip/ProgressBar.max_value:
		skipped = true
		Transit.change_scene_to_file("res://scenes/tent.tscn")
