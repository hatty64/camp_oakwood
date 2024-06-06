extends Node2D
@onready var damian_idle = $damian/AnimationPlayer

func _ready():
	MusicPlayer.play_music_level()
	if Global.loadin_dining == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1047
		$Christina.position.y = 685
	elif Global.first_time_in_dining == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1048
		$Christina.position.y = 672

var entered = false



func _process(_delta):
	damian_idle.play("thinking")
	if entered == true:
		Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
		Global.first_time_in_dining = false
		Global.loadin_dining == true



func _on_dining_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_dining_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false
