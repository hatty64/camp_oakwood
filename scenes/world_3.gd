extends Node2D

func _process(_delta):
	world_three()

func _on_world_3_exit_point_body_entered(body):
	if body.has_method("player"):
		global.transit_to_world3 = true


func _on_world_3_exit_point_body_exited(body):
	if body.has_method("player"):
		global.transit_to_world3 = false

func world_three():
	if global.transit_to_world3 == true:
		if global.current_scene == "world3":
			Transit.change_scene_to_file("res://scenes/world_2.tscn")
			global.finish_cangescene_world2()
