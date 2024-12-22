extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var skipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicPlayer.play_night_cutscene()
	MusicPlayer.play()
	$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	animation_player.play("fade_in")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_int_cutscene.dialogue"), "Start")
		await DialogueManager.dialogue_ended
	animation_player.play("christina_walk_up")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_int_cutscene.dialogue"), "Start_2")
		await DialogueManager.dialogue_ended
	animation_player.play("casper_walk_in")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_int_cutscene.dialogue"), "Start_3")
		await DialogueManager.dialogue_ended
	animation_player.play("step_aside")
	await animation_player.animation_finished
	await get_tree().create_timer(2.0).timeout
	MusicPlayer.stop()
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_int_cutscene.dialogue"), "Start_4")
		await DialogueManager.dialogue_ended
	animation_player.play("clancy_walks_in")
	await animation_player.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_int_cutscene.dialogue"), "Start_5")
		await DialogueManager.dialogue_ended
	animation_player.play("fade_out")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_int_cutscene.dialogue"), "Start_6")
		await DialogueManager.dialogue_ended
	Global.loadin_dining = true
	GlobalDays.after_night_temple = true
	Transit.change_scene_to_file("res://scenes/dining_area.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hold_to_skip()


func hold_to_skip():
	if $CanvasLayer3/hold_skip/ProgressBar.value == $CanvasLayer3/hold_skip/ProgressBar.max_value:
		MusicPlayer.stop()
		GlobalDays.after_night_temple = true
		skipped = true
		Global.loadin_dining = true
		Transit.change_scene_to_file("res://scenes/dining_area.tscn")
