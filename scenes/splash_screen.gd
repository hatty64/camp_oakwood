extends Control

@onready var animation_player: AnimationPlayer = $CanvasLayer2/AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$hatty_logo.visible = true
	$made_by.visible = true
	$godot.visible = false
	$made_with.visible = false
	$godot_engine.visible = false
	animation_player.play("fade_out")
	await animation_player.animation_finished
	audio_stream_player.play()
	await audio_stream_player.finished
	animation_player.play_backwards("fade_out")
	await animation_player.animation_finished
	$hatty_logo.visible = false
	$made_by.visible = false
	$godot.visible = true
	$made_with.visible = true
	$godot_engine.visible = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	await get_tree().create_timer(2.0).timeout
	animation_player.play_backwards("fade_out")
	await animation_player.animation_finished
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
