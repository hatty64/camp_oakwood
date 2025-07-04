extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("death")
	await $AnimationPlayer.animation_finished
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished
	$Timer.start()
	await $Timer.timeout
	Transit.change_scene_to_file("res://scenes/nightmare/scarecrow_maze.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
