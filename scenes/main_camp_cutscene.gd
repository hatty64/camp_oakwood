extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var skipped = false

func _ready() -> void:
	$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	animation_player.play("squirrel_running")
	await animation_player.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/ep_1_cutscenes.dialogue"), "Start_cookie_steal_1")
		await DialogueManager.dialogue_ended
	animation_player.play("maysie_turn_to_christina")
	await animation_player.animation_finished
	$Timer.wait_time = 1
	$Timer.start()
	await $Timer.timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/ep_1_cutscenes.dialogue"), "Start_cookie_steal_2")
		await DialogueManager.dialogue_ended
	animation_player.play("maysie_walk_back")
	await animation_player.animation_finished
	$Timer.wait_time = 2
	$Timer.start()
	await $Timer.timeout
	Global.loadin_world2 = true
	GlobalDays.ep1_day1_cutscene1 = false
	Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")

func _process(delta: float) -> void:
	skip_scene()


func skip_scene():
	if $CanvasLayer2/hold_skip/ProgressBar.value == $CanvasLayer2/hold_skip/ProgressBar.max_value:
		skipped = true
		Global.loadin_world2 = true
		GlobalDays.ep1_day1_cutscene1 = false
		Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
