extends Node2D

@onready var actionable_2 = $clancy/Actionable_2
@onready var casper_anim = $casper/casper_anim
@onready var animation_player = $CanvasLayer2/AnimationPlayer
@onready var eavesdrop = $eavesdrop
@onready var eavesdrop_girls: Area2D = $eavesdrop_girls
@onready var cutscenes: AnimationPlayer = $cutscenes

func _ready():
	Global.sprint_blocked = false
	if Global.loadin_main_camp == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 1352
		$Christina.position.y = 490
	elif Global.loadout_dining == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 1240
		$Christina.position.y = 606
	elif Global.loadin_world2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 1016
		$Christina.position.y = 612
	elif Global.loadin_main_camp_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(1, 0))
		$Christina.position.x = 801
		$Christina.position.y = 647
	
	casper_anim.play("reading")
	
	if Global.rain == true:
		BGSPlayer.play_rain()
		BGSPlayer.play()
	else:
		BGSPlayer.stop()


var entered = false

var entered_2 = false

var entered_3 = false

var entered_4 = false


func _process(_delta):
	if Global.got_map == true and Global.first_time_in_dining == false:
		actionable_2.dialogue_start = "Start_2"
	
	if GlobalDialogue.no_one_there == true:
		eavesdrop_girls.dialogue_start = "Start_4"
	else:
		eavesdrop_girls.dialogue_start = "Start_2"
	if entered == true:
		Transit.change_scene_to_file("res://scenes/vertical_path_to_camp.tscn")
		Global.loadin_tent_ext = false
		Global.loadin_tent_path = false
		Global.loadin_vertical_path = true
		Global.loadin_dining = false
		Global.loadin_world2 = false
		Global.loadin_main_camp = false
		Global.loadin_main_camp_2 = false
		Global.loadout_dining = false
	if entered_2 == true:
		if Input.is_action_just_pressed("accept"):
			Transit.change_scene_to_file("res://scenes/cabin_int_female.tscn")
			Global.loadin_dining = false
			Global.loadin_world2 = true
			Global.loadin_main_camp = false
			Global.loadin_main_camp_2 = false
			Global.loadout_dining = false
	if entered_3 == true:
		if Input.is_action_just_pressed("accept"):
			if Global.first_time_in_dining == false:
				Transit.change_scene_to_file("res://scenes/dining_area.tscn")
				Global.loadin_dining = true
				Global.loadin_world2 = false
				Global.loadin_main_camp = false
				Global.loadin_main_camp_2 = false
			else:
				Transit.change_scene_to_file("res://scenes/dining_cutscene.tscn")
				Global.loadin_dining = true
				Global.loadout_dining = false
	if entered_4 == true:
		Transit.change_scene_to_file("res://scenes/four_way.tscn")
		Global.loadin_dining = false
		Global.loadout_dining = false
		Global.loadin_world2 = false
		Global.loadin_main_camp = false
		Global.loadin_main_camp_2 = false
		Global.loadin_four_way = true
	
	if Global.first_time_in_office == true:
		$clancy.position.x = 1150
		$clancy.position.y = 590
		$casper.position.x = 0
		$casper.position.y = 0
		eavesdrop.position.x = 0
		eavesdrop.position.y = 0
		eavesdrop_girls.position.x = 0
		eavesdrop_girls.position.y = 0
	else:
		$clancy.position.x = 0
		$clancy.position.y = 0
		$casper.position.x = 845
		$casper.position.y = 592
		eavesdrop.position.x = 919
		eavesdrop.position.y = 589
		eavesdrop_girls.position.x = 1048
		eavesdrop_girls.position.y = 589
		
	if GlobalDays.ep_one_day_one == true:
		$casper.position.x = 0
		$casper.position.y = 0
		$maysie.position.x = 1180
		$maysie.position.y = 589
	else:
		$maysie.position.x = 0
		$maysie.position.y = 0
	
	if GlobalDays.after_night_temple == true:
		$maysie.position.x = 0
		$maysie.position.y = 0
	
	if Global.eavesdrop_day0_finished_boys == true:
		eavesdrop.dialogue_start = "Start_3"
	
	if Global.eavesdrop_day0_finished_girls == true:
		eavesdrop_girls.dialogue_start = "Start_3"
	
	night_vision_active()


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


func eavesdrop_boys_cabin() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/eavesdrop_dialogue.dialogue"), "Start_boys")
	await DialogueManager.dialogue_ended
	animation_player.play_backwards("fade_out")
	await animation_player.animation_finished
	Global.input_blocked = false

func eavesdrop_girls_cabin() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/eavesdrop_dialogue.dialogue"), "Start_girls")
	await DialogueManager.dialogue_ended
	animation_player.play_backwards("fade_out")
	await animation_player.animation_finished
	Global.input_blocked = false

func night_vision_active():
	if GlobalCostume.night_vision == true:
		$night_vision_stuff.visible = true
	else:
		$night_vision_stuff.visible = false
