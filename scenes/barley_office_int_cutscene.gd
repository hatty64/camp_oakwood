extends Node2D

@onready var animation_player = $AnimationPlayer

var skipped = false

func _ready():
	BGSPlayer.stop()
	Global.sunset = true
	await get_tree().create_timer(3.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/barley_office_cutscene.dialogue"), "Start")
		await DialogueManager.dialogue_ended
	animation_player.play("christina_walk_in")
	await animation_player.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/barley_office_cutscene.dialogue"), "Start_2")
		await DialogueManager.dialogue_ended
	animation_player.play("christina_takes_seat")
	await animation_player.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/barley_office_cutscene.dialogue"), "Start_3")
		await DialogueManager.dialogue_ended
	Global.rain = false
	Transit.change_scene_to_file("res://scenes/barley_office_int.tscn")


func _process(delta: float) -> void:
	hold_to_skip()


func hold_to_skip():
	if $CanvasLayer2/hold_skip/ProgressBar.value == $CanvasLayer2/hold_skip/ProgressBar.max_value:
		skipped = true
		Global.rain = false
		Global.sunset = true
		Transit.change_scene_to_file("res://scenes/barley_office_int.tscn")
