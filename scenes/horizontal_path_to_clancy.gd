extends Node2D

func _ready() -> void:
	if Global.loadin_horizontal_clancy == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(-1, 0))
		$Christina.position.x = 1263
		$Christina.position.y = 618
	elif Global.loadin_horizontal_clancy_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 1002
		$Christina.position.y = 491

var entered = false
var entered_2 = false

func _process(delta: float) -> void:
	if entered == true:
		Transit.change_scene_to_file("res://scenes/four_way.tscn")
		Global.loadin_four_way_3 = true
		Global.loadin_horizontal_clancy = false
		Global.loadin_horizontal_clancy_2 = false
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/clancy_cabin_ext.tscn")
		Global.loadin_four_way_3 = false
		Global.loadin_horizontal_clancy = false
		Global.loadin_horizontal_clancy_2 = false
		Global.loadin_clancy_ext = true


func _on_four_way_transit_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true


func _on_four_way_transit_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false


func _on_clancy_cabin_transit_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered_2 = true


func _on_clancy_cabin_transit_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered_2 = false
