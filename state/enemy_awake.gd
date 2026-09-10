extends State
class_name EnemyAwake

@export var enemy : CharacterBody2D
@export var animation_tree : AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")

func Enter():
	state_machine.travel("awake")
	await animation_tree.animation_finished
	Transitioned.emit(self, "Idle")

func physics_update(delta: float):
	pass
