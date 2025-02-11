extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.max_fps = 12


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.hunted_1 == true:
		$CanvasLayer2/ColorRect.color = "5b6ee1"
	elif Global.hunted_2 == true:
		$CanvasLayer2/ColorRect.color = "6abe30"
	else:
		$CanvasLayer2/ColorRect.color = "663931"


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://scenes/minigame/wolf_room_2.tscn")
