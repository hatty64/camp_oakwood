extends Node2D

@onready var choice_1: Button = $CanvasLayer2/Choice1
@onready var choice_2: Button = $CanvasLayer2/Choice2
@onready var canvas_layer_2: CanvasLayer = $CanvasLayer2


@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	$AnimationPlayer.play("to_the_fellas")
	await $AnimationPlayer.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/damian_and_vicky.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	$AnimationPlayer.play("vicky_shocked")
	MusicPlayer.pitchdown_music()
	timer.start()
	await timer.timeout
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/damian_and_vicky.dialogue"), "Start_2")
	await DialogueManager.dialogue_ended
	$AnimationPlayer.play("vicky_breath")
	await $AnimationPlayer.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/damian_and_vicky.dialogue"), "Start_3")
	await DialogueManager.dialogue_ended
	$AnimationPlayer.play("back_to_christina")
	await $AnimationPlayer.animation_finished
	canvas_layer_2.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func yell():
	$AnimationPlayer.play("vicky_yell")


func turn():
	$AnimationPlayer.play("turn_back")


func _on_canvas_layer_2_visibility_changed() -> void:
	choice_1.grab_focus()


func _on_choice_1_pressed() -> void:
	Global.help_damian = true
	canvas_layer_2.visible = false
	$AnimationPlayer.play("step_in")


func _on_choice_2_pressed() -> void:
	Global.help_damian = false
	canvas_layer_2.visible = false
	$AnimationPlayer.play("to_the_fellas")
