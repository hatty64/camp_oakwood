extends State
class_name EnemySleep

@export var enemy : CharacterBody2D
@export var animation_tree : AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")

var sleep_time : float

func Enter():
	sleep_time = 5.0
	enemy.velocity = Vector2.ZERO
	state_machine.travel("sleep")
	await animation_tree.animation_finished

func physics_update(delta):
	enemy.velocity = Vector2.ZERO

func Update(delta: float):
	if sleep_time > 0:
		sleep_time -= delta
	else:
		enemy.sleep = false
		Transitioned.emit(self, "Awake")

	 #Optional: wake up if player gets close
	#if sleep_time <= 0:
