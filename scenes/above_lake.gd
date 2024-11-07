extends Node2D

func _ready() -> void:
	if Global.loadin_above_lake_left == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 809
		$Christina.position.y = 781
	elif Global.loadin_above_lake_right == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1159
		$Christina.position.y = 781

var entered = false
var entered_2 = false
var entered_3 = false

func _process(delta: float) -> void:
	if entered == true:
		Transit.change_scene_to_file("res://scenes/lake.tscn")
		Global.loadin_lake_3 = true
		Global.loadin_lake_4 = false
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/lake.tscn")
		Global.loadin_lake_3 = false
		Global.loadin_lake_4 = true



func _on_lake_transit_left_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true


func _on_lake_transit_left_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false


func _on_lake_transit_right_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered_2 = true


func _on_lake_transit_right_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered_2 = false
