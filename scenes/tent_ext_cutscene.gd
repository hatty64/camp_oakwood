extends Node2D

@onready var clancy = $clancy
@onready var clancy_anim := $clancy/AnimationPlayer
@onready var exclamation = $clancy/exclamation
@onready var camera_anim := $Camera2DPlus/AnimationPlayer

var skipped = false

func _ready():
	$Camera2DPlus.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	#$Camera2DPlus.horizontal_enabled = true
	Global.game_first_loadin = false
	BGSPlayer.play_rain()
	BGSPlayer.play()
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
	if skipped != true:
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/tent_ext_dialogue.dialogue"), "Start")
		await DialogueManager.dialogue_ended
	clancy_anim.speed_scale = 1.0
	clancy_anim.play("move_down")
	camera_anim.play_backwards("pan_down")
	await camera_anim.animation_finished
	await get_tree().create_timer(1.0).timeout
	Transit.change_scene_to_file("res://scenes/tent_ext.tscn")
	BGSPlayer.stop()


func _process(delta: float) -> void:
	hold_to_skip()

func hold_to_skip():
	if $CanvasLayer2/hold_skip/ProgressBar.value == $CanvasLayer2/hold_skip/ProgressBar.max_value:
		skipped = true
		Transit.change_scene_to_file("res://scenes/tent_ext.tscn")
		BGSPlayer.stop()
		Global.game_first_loadin = false
