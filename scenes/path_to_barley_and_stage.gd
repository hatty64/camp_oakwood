extends Node2D

func _ready():
	if Global.loadin_path_to_barley == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(1, 0))
		$Christina.position.x = 802
		$Christina.position.y = 508
	elif Global.loadin_path_to_barley_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 955
		$Christina.position.y = 429
	elif Global.loadin_path_to_barley_3 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(-1, 0))
		$Christina.position.x = 1104
		$Christina.position.y = 508

var entered = false
var entered_2 = false
var entered_3 = false

func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/lake.tscn")
		Global.loadin_lake_1 = false
		Global.loadin_lake_2 = true
		Global.loadin_four_way_2 = false
		Global.loadin_path_to_barley = false
		Global.loadin_path_to_barley_2 = false
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/barley_office_ext.tscn")
		Global.loadin_lake_1 = false
		Global.loadin_lake_2 = false
		Global.loadin_four_way_2 = false
		Global.loadin_path_to_barley = false
		Global.loadin_path_to_barley_2 = false
		Global.loadin_barley_office_ext = true
	if entered_3 == true:
		Transit.change_scene_to_file("res://scenes/stage_ext.tscn")
		Global.loadin_lake_1 = false
		Global.loadin_lake_2 = false
		Global.loadin_four_way_2 = false
		Global.loadin_path_to_barley = false
		Global.loadin_path_to_barley_2 = false
		Global.loadin_barley_office_ext = false
		Global.loadin_stage = true


func _on_path_barley_stage_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_path_barley_stage_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false


func _on_barley_office_ext_transit_point_body_entered(body):
	if body.has_method("player"):
		entered_2 = true


func _on_barley_office_ext_transit_point_body_exited(body):
	if body.has_method("player"):
		entered_2 = false


func _on_stage_transit_point_body_entered(body):
	if body.has_method("player"):
		entered_3 = true


func _on_stage_transit_point_body_exited(body):
	if body.has_method("player"):
		entered_3 = false
