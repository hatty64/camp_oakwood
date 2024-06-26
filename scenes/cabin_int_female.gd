extends Node2D

func _ready():
	if Global.loadin_world2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))


var entered = false



func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
		Global.loadin_world2 == true
		Global.loadin_dining == false
		Global.loadin_main_camp = false



func _on_cabin_f_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_cabin_f_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false
