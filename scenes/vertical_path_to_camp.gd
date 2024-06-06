extends Node2D


func _ready():
	if Global.loadin_vertical_path == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = Global.player_vertical_start_positionx
		$Christina.position.y = Global.player_vertical_start_positiony
	else:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = Global.player_vertical_exit_positionx
		$Christina.position.y = Global.player_vertical_exit_positiony

var entered = false

var entered_2 = false



func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/path_to_tent.tscn")
		Global.loadin_tent_path = false
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
		Global.loadin_main_camp = true


func _on_vertical_to_tent_path_trans_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_vertical_to_tent_path_trans_point_body_exited(body):
	if body.has_method("player"):
		entered = false


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		entered_2 = true


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		entered_2 = false
