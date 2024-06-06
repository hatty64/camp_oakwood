extends Node2D

func _ready():
	BirdSound.play()
	BirdSound.play_music_level()
	if Global.loadin_tent_ext == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = Global.player_tent_ext_exit_positionx
		$Christina.position.y = Global.player_tent_ext_exit_positiony
	else:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = Global.player_tent_ext_start_positionx
		$Christina.position.y = Global.player_tent_ext_start_positiony

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


