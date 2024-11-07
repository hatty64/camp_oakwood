extends Node2D

@onready var casper_anim: AnimationPlayer = $casper/casper_anim
@onready var cutscene: AnimationPlayer = $cutscene

var entered_cut = false
var cutscene_play = false

func _ready() -> void:
	$Christina/Camera2D/ColorRect.visible = false
	$Christina/Camera2D/ColorRect2.visible = false
	casper_anim.play("reading")


func _process(delta: float) -> void:
	if entered_cut == true:
		if Input.is_action_just_pressed("accept"):
			cutscene_play = true
			cutscene.play("door_open")
	
	if cutscene_play == true:
		Global.input_blocked = true
	else:
		Global.input_blocked = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered_cut = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered_cut = false
