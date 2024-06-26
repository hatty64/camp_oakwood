extends Node2D

@onready var actionable_2 = $clancy/Actionable_2

func _ready():
	if Global.loadin_main_camp == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = Global.player_camp_out_positionx
		$Christina.position.y = Global.player_camp_out_positiony
	elif Global.loadout_dining == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 1240
		$Christina.position.y = 606
	elif Global.loadin_world2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 1016
		$Christina.position.y = 604
	elif Global.loadin_main_camp_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(1, 0))
		$Christina.position.x = Global.player_main_camp_exit_positionx
		$Christina.position.y = Global.player_main_camp_exit_positiony


var entered = false

var entered_2 = false

var entered_3 = false

var entered_4 = false


func _process(_delta):
	if Global.got_map == true and Global.first_time_in_dining == false:
		actionable_2.dialogue_start = "Start_2"
	if entered == true:
		Transit.change_scene_to_file("res://scenes/vertical_path_to_camp.tscn")
		Global.loadin_tent_ext = false
		Global.loadin_tent_path = false
		Global.loadin_vertical_path = true
		Global.loadin_dining = false
		Global.loadin_world2 = false
		Global.loadin_main_camp = false
		Global.loadin_main_camp_2 = false
	if entered_2 == true:
		if Input.is_action_just_pressed("accept"):
			Transit.change_scene_to_file("res://scenes/cabin_int_female.tscn")
			Global.loadin_dining = false
			Global.loadin_world2 = true
			Global.loadin_main_camp = false
			Global.loadin_main_camp_2 = false
	if entered_3 == true:
		if Input.is_action_just_pressed("accept"):
			if Global.first_time_in_dining == false:
				Transit.change_scene_to_file("res://scenes/dining_area.tscn")
				Global.loadin_dining = true
				Global.loadin_world2 = false
				Global.loadin_main_camp = false
				Global.loadin_main_camp_2 = false
			else:
				Transit.change_scene_to_file("res://scenes/dining_area_cutscene.tscn")
				Global.loadin_dining = true
	if entered_4 == true:
		Transit.change_scene_to_file("res://scenes/four_way.tscn")
		Global.loadin_dining = false
		Global.loadin_world2 = false
		Global.loadin_main_camp = false
		Global.loadin_main_camp_2 = false
		Global.loadin_four_way = true


func _on_vertical_path_transition_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_vertical_path_transition_point_body_exited(body):
	if body.has_method("player"):
		entered = false






func _on_cabin_f_transition_point_body_entered(body):
	if body.has_method("player"):
		entered_2 = true


func _on_cabin_f_transition_point_body_exited(body):
	if body.has_method("player"):
		entered_2 = false






func _on_dining_transition_point_body_entered(body):
	if body.has_method("player"):
		entered_3 = true


func _on_dining_transition_point_body_exited(body):
	if body.has_method("player"):
		entered_3 = false



func _on_four_way_transition_point_body_entered(body):
	if body.has_method("player"):
		entered_4 = true


func _on_four_way_transition_point_body_exited(body):
	if body.has_method("player"):
		entered_4 = false
