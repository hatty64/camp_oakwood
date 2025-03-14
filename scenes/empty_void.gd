extends Node2D

@onready var canvasmod := $CanvasModulate
@onready var night_eye := $night_eye/AnimationPlayer
@onready var zoom := $Camera2D/AnimationPlayer
@onready var fade := $CanvasModulate/AnimationPlayer
@onready var music := $AudioStreamPlayer2D/AnimationPlayer
@onready var jumpscare := $jumpscare



func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().create_timer(6.0).timeout
	DialogueManager.show_dialogue_night_balloon(load("res://dialogue/night_eye.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	fade.play("fade")
	music.play("music_fade_out")
	await fade.animation_finished
	await get_tree().create_timer(4.0).timeout
	jumpscare.play()
	night_eye.play("twitch")
	zoom.play("zoom_in")
	fade.play("color")
	await get_tree().create_timer(0.1).timeout
	$Camera2D.add_shake(3)
	DialogueManager.show_dialogue_night_balloon(load("res://dialogue/wake_up.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	get_tree().change_scene_to_file("res://scenes/tent_cutscene.tscn")
