extends Node2D

var skipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Book.visible = false
	$CanvasModulate.visible = false
	$librarian/AnimationPlayer_librarian.play("librarian")
	$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("turn_to_each_other")
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/librarby_cutscene.dialogue"), "Start")
		await DialogueManager.dialogue_ended
	$AnimationPlayer.play("walk_to_counter")
	await $AnimationPlayer.animation_finished
	#await get_tree().create_timer(2.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/librarby_cutscene.dialogue"), "Start_2")
		await DialogueManager.dialogue_ended
	$Book.visible = true
	await get_tree().create_timer(1.0).timeout
	$CanvasModulate.visible = true
	await get_tree().create_timer(1.0).timeout
	$CanvasModulate.visible = false
	await get_tree().create_timer(1.0).timeout
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/librarby_cutscene.dialogue"), "Start_3")
		await DialogueManager.dialogue_ended
	$AnimationPlayer.play("dam_walk_to_chris")
	await $AnimationPlayer.animation_finished
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/librarby_cutscene.dialogue"), "Start_4")
		await DialogueManager.dialogue_ended
	$AnimationPlayer.play("damian_walk_away")
	await $AnimationPlayer.animation_finished
	Transit.change_scene_to_file("res://scenes/library.tscn")

func _process(delta: float) -> void:
	skip_scene()


func skip_scene():
	if $CanvasLayer2/hold_skip/ProgressBar.value == $CanvasLayer2/hold_skip/ProgressBar.max_value:
		skipped = true
		Global.loadin_world2 = true
		GlobalDays.ep1_day1_cutscene1 = false
		Transit.change_scene_to_file("res://scenes/library.tscn")
