extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	Global.sprint_blocked = true

func _process(delta):
	await DialogueManager.dialogue_ended
	Global.input_blocked = true
	animation_player.play("transform")
