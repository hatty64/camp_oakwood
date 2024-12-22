extends Node2D

@onready var casper_anim: AnimationPlayer = $casper/casper_anim
@onready var cutscene: AnimationPlayer = $cutscene

var entered_cut = false


func _ready() -> void:
	$Christina/Camera2D/ColorRect.visible = false
	$Christina/Camera2D/ColorRect2.visible = false
	casper_anim.play("reading")
	$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))


func _process(delta: float) -> void:
	if entered_cut == true:
		if Input.is_action_just_pressed("accept"):
			if GlobalDialogue.door_open == false:
				$open_door/CollisionShape2D.disabled = true
				$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
				cutscene_play()
				cutscene.play("door_open")
				await cutscene.animation_finished
				DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/night_temple_ext_cutscene.dialogue"), "Start_door_open")
				await DialogueManager.dialogue_ended
				cutscene_stop()
				GlobalDialogue.door_open = true
				$open_door/CollisionShape2D.disabled = false
			else:
				Transit.change_scene_to_file("res://scenes/night_temple_int.tscn")
	





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered_cut = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered_cut = false

func cutscene_play():
	Global.input_blocked = true

func cutscene_stop():
	Global.input_blocked = false


func _on_exit_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.input_blocked = true
		$Christina.input_vector = Vector2.ZERO
		$Christina.position.y = 836
		$Christina.state_machine.travel("idle")
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		DialogueManager.show_dialogue_regular_balloon_up(load("res://dialogue/night_temple_ext_interact.dialogue"), "Start_walk_away")
		await DialogueManager.dialogue_ended
		Global.input_blocked = false
