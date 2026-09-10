extends Node2D

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
	$AnimationPlayer.play("to_the_fellas")
	await $AnimationPlayer.animation_finished
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/damian_and_vicky.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	MusicPlayer.pitchdown_music()
	timer.start()
	await timer.timeout
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
