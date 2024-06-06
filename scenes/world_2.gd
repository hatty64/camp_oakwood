extends Node2D

func _ready():
	if global.loadin_world2 == true:
		$Christina.position.x = global.player_world2_start_positionx
		$Christina.position.y = global.player_world2_start_positiony
	else:
		$Christina.position.x = global.player_world3_exit_positionx
		$Christina.position.y = global.player_world3_exit_positiony

func _process(_delta):
	change_scene()
	world_three()


func _on_world_2_exit_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true


func _on_world_2_exit_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world2":
			Transit.change_scene_to_file("res://scenes/world1.tscn")
			global.loadin_world2 = false
			global.finish_changescene()


func _on_world_3_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transit_to_world3 = true


func _on_world_3_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transit_to_world3 = false
		
func world_three():
	if global.transit_to_world3 == true:
		if global.current_scene == "world2":
			Transit.change_scene_to_file("res://scenes/world_3.tscn")
			global.loadin_world2 = false
			global.finish_cangescene_world2()
