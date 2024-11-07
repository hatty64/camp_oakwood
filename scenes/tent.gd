extends Node2D

func _ready():
	Global.sprint_blocked = true
	if Global.game_first_loadin == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = Global.player_first_tent_positionx
		$Christina.position.y = Global.player_first_tent_positiony
	else:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = Global.player_tent_positionx
		$Christina.position.y = Global.player_tent_positiony
	BGSPlayer.stop()


var entered = false



func _on_tent_exit_point_body_entered(body):
	if body.has_method("player"):
		entered = true


func _on_tent_exit_point_body_exited(body):
	if body.has_method("player"):
		entered = false

func _process(_delta):
	if entered == true:
		if Global.game_first_loadin == true:
			Transit.change_scene_to_file("res://scenes/tent_ext_cutscene.tscn")
		else:
			Transit.change_scene_to_file("res://scenes/tent_ext.tscn")
	if GlobalCostume.raincoat_unlocked == false:
		$Actionable.dialogue_start = "Start_raincoat"
		$raincoat_item.visible = true
	else:
		$Actionable.dialogue_start = "Start"
		$raincoat_item.visible = false
