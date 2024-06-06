extends Node2D

func _ready():
	if Global.loadin_four_way == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(-1, 0))
		$Christina.position.x = 1201
		$Christina.position.y = 629
	elif Global.loadin_four_way_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 956
		$Christina.position.y = 521

var entered = false
var entered_2 = false


func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
		Global.loadin_main_camp_2 = true
		Global.loadin_four_way = false
		Global.loadin_four_way_2 = false
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/lake.tscn")
		Global.loadin_main_camp_2 = false
		Global.loadin_four_way = false
		Global.loadin_four_way_2 = false
		Global.loadin_lake_1 = true


func _on_main_camp_transition_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_main_camp_transition_point_body_exited(body):
	if body.has_method("player"):
		entered = false


func _on_lake_transit_point_body_entered(body):
	if body.has_method("player"):
		entered_2 = true


func _on_lake_transit_point_body_exited(body):
	if body.has_method("player"):
		entered_2 = false
