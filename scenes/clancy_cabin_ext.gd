extends Node2D

func _ready() -> void:
	if Global.loadin_clancy_ext == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1004
		$Christina.position.y = 588

var entered = false

func _process(_delta: float) -> void:
	if entered == true:
		Transit.change_scene_to_file("res://scenes/horizontal_path_to_clancy.tscn")
		Global.loadin_horizontal_clancy_2 = true
		Global.loadin_horizontal_clancy = false
		Global.loadin_clancy_ext = false



func _on_horizontal_path_transit_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true


func _on_horizontal_path_transit_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false
