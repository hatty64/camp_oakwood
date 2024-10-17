extends Node2D
@onready var damian_idle = $damian/AnimationPlayer
@onready var jacob = $Jacob
@onready var maysie = $maysie
@onready var maya = $maya
@onready var damian = $damian
@onready var dinah = $dinah
@onready var actionable_2 = $Actionable2


func _ready():
	Global.sprint_blocked = true
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
		Global.loadin_main_camp = false
		Global.loadout_dining = true
		Global.loadin_dining = false
	day0_finished()



func _on_dining_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_dining_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false

func day0_finished():
	if Global.first_time_in_office != true:
		jacob.position.x = 0
		jacob.position.y = 0
		damian.position.x = 0
		damian.position.y = 0
		maysie.position.x = 0
		maysie.position.y = 0
		maya.position.x = 0
		maya.position.y = 0
		dinah.position.x = 0
		dinah.position.y = 0
		actionable_2.position.x = 0
		actionable_2.position.y = 0
	else:
		jacob.position.x = 961
		jacob.position.y = 589
		damian.position.x = 1028
		damian.position.y = 576
		maysie.position.x = 894
		maysie.position.y = 633
		maya.position.x = 1141
		maya.position.y = 668
		dinah.position.x = 1050
		dinah.position.y = 576
		actionable_2.position.x = 1039
		actionable_2.position.y = 582
