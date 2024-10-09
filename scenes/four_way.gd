extends Node2D

func _ready():
	if Global.loadin_four_way == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(-1, 0))
		$Christina.position.x = 1200
		$Christina.position.y = 651
	elif Global.loadin_four_way_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 937
		$Christina.position.y = 521
	elif Global.loadin_four_way_3 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(1, 0))
		$Christina.position.x = 802
		$Christina.position.y = 651

var entered = false
var entered_2 = false
var entered_3 = false


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
	if entered_3 == true:
		Transit.change_scene_to_file("res://scenes/horizontal_path_to_clancy.tscn")
		Global.loadin_horizontal_clancy = true
		Global.loadin_horizontal_clancy_2 = false
		Global.loadin_main_camp_2 = false
		Global.loadin_four_way = false
		Global.loadin_four_way_2 = false
		Global.loadin_lake_1 = false


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


func _on_path_clancy_transit_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered_3 = true


func _on_path_clancy_transit_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered_3 = false
