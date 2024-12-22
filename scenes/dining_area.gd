extends Node2D
@onready var damian_idle = $damian/AnimationPlayer
@onready var jacob = $Jacob
@onready var maysie = $maysie
@onready var maya = $maya
@onready var damian = $damian
@onready var dinah = $dinah
@onready var actionable_2 = $Actionable2
@onready var damian_normal: CharacterBody2D = $damian_normal
@onready var dinah_head_turn: CharacterBody2D = $dinah_head_turn
@onready var casper: CharacterBody2D = $casper
@onready var casper_anim: AnimationPlayer = $casper/casper_anim


func _ready():
	Global.sprint_blocked = true
	BGSPlayer.stop()
	if Global.loadin_dining == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1047
		$Christina.position.y = 685
	elif Global.first_time_in_dining == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 1048
		$Christina.position.y = 672
	$dinah_head_turn/AnimationPlayer.play("RESET")
	$AnimationPlayer.play("RESET")

var entered = false



func _process(_delta):
	damian_idle.play("thinking")
	casper_anim.play("reading")
	if entered == true:
		Transit.change_scene_to_file("res://scenes/main_camp_outside.tscn")
		Global.first_time_in_dining = false
		Global.loadin_main_camp = false
		Global.loadout_dining = true
		Global.loadin_dining = false
	day0_finished()
	if GlobalDays.ep_one_day_one == true:
		MusicPlayer.play_a_new_day()



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
		$Jacob/Sprite2D.frame = 12
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
		damian_normal.position.x = 0
		damian_normal.position.y = 0
		dinah_head_turn.position.x = 0
		dinah_head_turn.position.y = 0
		casper.position.x = 0
		casper.position.y = 0
	else:
		jacob.position.x = 961
		jacob.position.y = 589
		$Jacob/Sprite2D.frame = 12
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
		actionable_2.dialogue_start = "Start"
		damian_normal.position.x = 0
		damian_normal.position.y = 0
		dinah_head_turn.position.x = 0
		dinah_head_turn.position.y = 0
		casper.position.x = 0
		casper.position.y = 0
	if GlobalDays.ep_one_day_one == true:
		jacob.position.x = 0
		jacob.position.y = 0
		damian.position.x = 0
		damian.position.y = 0
		maysie.position.x = 0
		maysie.position.y = 0
		maya.position.x = 1141
		maya.position.y = 668
		dinah.position.x = 0
		dinah.position.y = 0
		actionable_2.position.x = 1151
		actionable_2.position.y = 582
		actionable_2.dialogue_start = "Start_ep_one_day_one"
		damian_normal.position.x = 1142
		damian_normal.position.y = 573
		dinah_head_turn.position.x = 1161
		dinah_head_turn.position.y = 573
		casper.position.x = 0
		casper.position.y = 0
	if GlobalDays.after_night_temple == true and GlobalDays.ep_one_day_one == true:
		jacob.position.x = 1191
		jacob.position.y = 632
		$Jacob/Sprite2D.frame = 8
		damian.position.x = 0
		damian.position.y = 0
		maysie.position.x = 894
		maysie.position.y = 633
		maya.position.x = 1141
		maya.position.y = 668
		dinah.position.x = 0
		dinah.position.y = 0
		actionable_2.position.x = 1151
		actionable_2.position.y = 582
		actionable_2.dialogue_start = "Start_quest"
		damian_normal.position.x = 1142
		damian_normal.position.y = 573
		dinah_head_turn.position.x = 1161
		dinah_head_turn.position.y = 573
		casper.position.x = 1083
		casper.position.y = 561

func cutscene_play():
	Global.input_blocked = true

func cutscene_stop():
	Global.input_blocked = false

func dinah_turns_head():
	cutscene_play()
	MusicPlayer.stream_paused = true
	await get_tree().create_timer(1.0).timeout
	$dinah_head_turn/AnimationPlayer.play("dinah_head_turn")
	await $AnimationPlayer.animation_finished
	$dinah_head_turn/AnimationPlayer.play("RESET")
	MusicPlayer.stream_paused = false

func fade_out():
	cutscene_play()
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/narrator_transit.dialogue"), "Start_damian_quest")
