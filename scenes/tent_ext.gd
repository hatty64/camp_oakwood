extends Node2D

func _ready():
	Global.sprint_blocked = false
	if Global.loadin_tent_ext == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1001
		$Christina.position.y = 812
	else:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 1001
		$Christina.position.y = 684
	if Global.rain == true:
		BGSPlayer.play_rain()
		BGSPlayer.play()
	else:
		BGSPlayer.stop()

var entered = false

var entered_2 = false


func _on_tent_enter_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_tent_enter_point_body_exited(body):
	if body.has_method("player"):
		entered = false

func _process(_delta):
	if entered == true:
		if Input.is_action_just_pressed("accept"):
			Transit.change_scene_to_file("res://scenes/tent.tscn")
			Global.loadin_tent = true
			Global.loadin_tent_ext = false
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/path_to_tent.tscn")
		Global.loadin_tent_path = true
		Global.loadin_tent_ext = false
	



func _on_tent_ext_exit_point_body_entered(body):
	if body.has_method("player"):
		entered_2 = true


func _on_tent_ext_exit_point_body_exited(body):
	if body.has_method("player"):
		entered_2 = false
