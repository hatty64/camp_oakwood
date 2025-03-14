extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 25:
		$AnimationPlayer.play("alert")
		await $AnimationPlayer.animation_finished
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
