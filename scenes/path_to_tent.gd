extends Node2D

func _ready():
	if Global.loadin_tent_path == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = Global.player_tent_path_start_positionx
		$Christina.position.y = Global.player_tent_path_start_positiony
	else:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = Global.player_tent_path_exit_positionx
		$Christina.position.y = Global.player_tent_path_exit_positiony

var entered = false

var entered_2 = false



func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/tent_ext.tscn")
		Global.loadin_tent_ext = true
		Global.loadin_tent_path = false
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/vertical_path_to_camp.tscn")
		Global.loadin_tent_path = false
		Global.loadin_vertical_path = false



func _on_tent_path_start_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_tent_path_start_point_body_exited(body):
	if body.has_method("player"):
		entered = false



func _on_tent_path_exit_point_body_entered(body):
	if body.has_method("player"):
		entered_2 = true


func _on_tent_path_exit_point_body_exited(body):
	if body.has_method("player"):
		entered_2 = false
