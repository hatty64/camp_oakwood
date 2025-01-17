extends Node2D

@onready var maysie = $maysie
@onready var maya = $maya
@onready var dinah = $dinah

func _ready():
	BGSPlayer.stop()
	Global.sprint_blocked = true
	if Global.loadin_world2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1048
		$Christina.position.y = 652
	elif GlobalDays.woke_up == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(1, 0))
		$Christina.position.x = 1014
		$Christina.position.y = 552


var entered = false



func _process(_delta):
	if entered == true:
		if GlobalDays.ep1_day1_cutscene1 == true:
			Transit.change_scene_to_file("res://scenes/main_camp_cutscene.tscn")
		else:
			Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
			Global.loadin_world2 = true
			Global.loadin_dining = false
			Global.loadin_main_camp = false
			Global.loadout_dining = false
			GlobalDays.woke_up = false
	char_in_cabin()
	if GlobalDays.ep_one_day_one == true:
		MusicPlayer.play_a_new_day()
	
	if GlobalDays.start_transit == true:
		Global.input_blocked = true
	
	night_vision_active()



func _on_cabin_f_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_cabin_f_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false

func char_in_cabin():
	if Global.first_time_in_office == true or GlobalDays.ep_one_day_one == true:
		maysie.position.x = 0
		maysie.position.y = 0
		maya.position.x = 0
		maya.position.y = 0
		dinah.position.x = 0
		dinah.position.y = 0
		GlobalDialogue.dinah_in_cabin = false
		GlobalDialogue.maysie_in_cabin = false
		GlobalDialogue.maya_in_cabin = false
		GlobalDialogue.no_one_there = true
	else:
		maysie.position.x = 1108
		maysie.position.y = 608
		maya.position.x = 1072
		maya.position.y = 536
		dinah.position.x = 995
		dinah.position.y = 597
		GlobalDialogue.dinah_in_cabin = true
		GlobalDialogue.maysie_in_cabin = true
		GlobalDialogue.maya_in_cabin = true
		GlobalDialogue.no_one_there = false
		GlobalDialogue.sleepable = true

func episode_one_day_one():
	Transit.change_scene_to_file("res://scenes/chapter_transit.tscn")

func night_vision_active():
	if GlobalCostume.night_vision == true:
		$night_vision_stuff.visible = true
	else:
		$night_vision_stuff.visible = false
