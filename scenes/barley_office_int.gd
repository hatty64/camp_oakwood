extends Node2D

func _ready():
	BGSPlayer.stop()
	if Global.loadin_barley_office == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 968
		$Christina.position.y = 621
	else:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 969
		$Christina.position.y = 583

var entered = false

func _process(delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/barley_office_ext.tscn")
		Global.loadin_barley_office_ext_2 = true
		Global.loadin_barley_office = false
		Global.loadin_barley_office_ext = false
		Global.first_time_in_office = false


func _on_barley_office_exit_pos_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_barley_office_exit_pos_body_exited(body):
	if body.has_method("player"):
		entered = false
