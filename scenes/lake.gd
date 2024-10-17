extends Node2D


func _ready():
	if Global.loadin_lake_1 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 873
		$Christina.position.y = 685
	elif Global.loadin_lake_2 == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(-1, 0))
		$Christina.position.x = 1266
		$Christina.position.y = 468



var entered = false
var entered_2 = false


func _process(_delta):
	if entered == true:
		Transit.change_scene_to_file("res://scenes/four_way.tscn")
		Global.loadin_lake_1 = false
		Global.loadin_lake_2 = false
		Global.loadin_four_way_2 = true
	if entered_2 == true:
		Transit.change_scene_to_file("res://scenes/path_to_barley_and_stage.tscn")
		Global.loadin_lake_1 = false
		Global.loadin_lake_2 = false
		Global.loadin_four_way_2 = false
		Global.loadin_path_to_barley = true
	
	if Global.first_time_in_office != true:
		$ester.position.x = 0
		$ester.position.y = 0
	else:
		$ester.position.x = 777
		$ester.position.y = 440
	#if $Christina.input_vector == Vector2.ZERO:
		#$Christina.state_machine.travel("idle")


func _on_lake_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_lake_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false


func _on_lake_exit_point_2_body_entered(body):
	if body.has_method("player"):
		print($Christina.input_vector)
		if Global.first_time_in_dining == true:
			GlobalDays.cutscene_playing = true
			$Christina.input_vector = Vector2.ZERO
			$Christina.position.x = 1263
			$Christina.state_machine.travel("idle")
			$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(-1, 0))
			DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/ester_dialogue.dialogue"), "Start_2")
			Global.annoying_ester += 1
			await DialogueManager.dialogue_ended
			GlobalDays.cutscene_playing = false
		else:
			entered_2 = true


func _on_lake_exit_point_2_body_exited(body):
	if body.has_method("player"):
		entered_2 = false
