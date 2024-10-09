extends Node2D

@onready var maysie = $maysie
@onready var maya = $maya
@onready var dinah = $dinah

func _ready():
	Global.sprint_blocked = true
	if Global.loadin_world2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))


var entered = false



func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
		Global.loadin_world2 = true
		Global.loadin_dining = false
		Global.loadin_main_camp = false
		Global.loadout_dining = false
	char_in_cabin()



func _on_cabin_f_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_cabin_f_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false

func char_in_cabin():
	if Global.first_time_in_office == true:
		maysie.position.x = 0
		maysie.position.y = 0
		maya.position.x = 0
		maya.position.y = 0
		dinah.position.x = 0
		dinah.position.y = 0
		GlobalDialogue.dinah_in_cabin = false
		GlobalDialogue.maysie_in_cabin = false
		GlobalDialogue.maya_in_cabin = false
		
	else:
		maysie.position.x = 1107
		maysie.position.y = 608
		maya.position.x = 1072
		maya.position.y = 536
		dinah.position.x = 995
		dinah.position.y = 597
		GlobalDialogue.dinah_in_cabin = true
		GlobalDialogue.maysie_in_cabin = true
		GlobalDialogue.maya_in_cabin = true
		GlobalDialogue.sleepable = true

func thank_you() -> void:
	Transit.change_scene_to_file("res://scenes/thank_you_test.tscn")
