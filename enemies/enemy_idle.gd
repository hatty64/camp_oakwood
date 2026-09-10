extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var animation_tree : AnimationTree
@export var move_speed := 10.0
var player : CharacterBody2D

@onready var state_machine = animation_tree.get("parameters/playback")

var move_direction : Vector2
var wander_time : float


func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func physics_update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
		
		update_animation_parameters(move_direction)
		
		pick_new_state()
	
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 50:
		Transitioned.emit(self, "Follow")
	
	if enemy.sleep == true:
		Transitioned.emit(self, "Sleep")


func update_animation_parameters(move_dir : Vector2):
	if(move_dir != Vector2.ZERO):
		animation_tree.set("parameters/move/blend_position", move_dir)
		animation_tree.set("parameters/idle/blend_position", move_dir)

func pick_new_state():
	if(enemy.velocity != Vector2.ZERO):
		state_machine.travel("move")
	if (enemy.velocity == Vector2.ZERO):
		state_machine.travel("idle")
