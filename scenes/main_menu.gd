extends Control

func _ready() -> void:
	$CanvasLayer2/AnimationPlayer.play("fade_out")
	await $CanvasLayer2/AnimationPlayer.animation_finished
	$NinePatchRect/MarginContainer/VBoxContainer/play.grab_focus()


func _on_play_pressed() -> void:
	$music.stop()
	$piano_sound.play()
	$night_whisper.play()
	$NinePatchRect/MarginContainer/VBoxContainer/play.release_focus()
	$CanvasLayer2/AnimationPlayer.play_backwards("fade_out")
	await $CanvasLayer2/AnimationPlayer.animation_finished
	await $piano_sound.finished
	get_tree().change_scene_to_file("res://scenes/empty_void.tscn")
