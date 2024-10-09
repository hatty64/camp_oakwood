extends Node2D

func _ready():
	if Global.loadin_barley_office_ext == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 953
		$Christina.position.y = 580
	elif Global.loadin_barley_office_ext_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 953
		$Christina.position.y = 526

var entered = false
var entered_2 = false

func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/path_to_barley_and_stage.tscn")
		Global.loadin_path_to_barley = false
		Global.loadin_path_to_barley_2 = true
		Global.loadin_barley_office = false
	if entered_2 == true:
		if Global.first_time_in_office != true:
			if Input.is_action_just_pressed("accept"):
				Transit.change_scene_to_file("res://scenes/barley_office_int.tscn")
				Global.loadin_path_to_barley = false
				Global.loadin_path_to_barley_2 = false
				Global.loadin_barley_office = true
		else:
			if Input.is_action_just_pressed("accept"):
				Transit.change_scene_to_file("res://scenes/barley_office_int_cutscene.tscn")
				Global.loadin_path_to_barley = false
				Global.loadin_path_to_barley_2 = false
				Global.loadin_barley_office = false




func _on_barley_office_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_barley_office_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false


func _on_barley_office_transit_point_body_entered(body):
	if body.has_method("player"):
		entered_2 = true


func _on_barley_office_transit_point_body_exited(body):
	if body.has_method("player"):
		entered_2 = false
