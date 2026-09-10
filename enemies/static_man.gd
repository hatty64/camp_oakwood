extends CharacterBody2D

@export var move_speed : float = 40.0
@export var separation_radius : float = 50.0
@export var separation_strength : float = 20.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var nav_agent := $NavigationAgent2D
@onready var timer_awake: Timer = $TimerAwake
@onready var player = $"../Christina"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


var move_direction : Vector2 = Vector2.ZERO
var chasing = false

var dead = false

func _ready() -> void:
	#collision_shape_2d.disabled = false
	#state_machine.travel("awake")
	animated_sprite_2d.play("default")
	makepath()


func _physics_process(delta: float) -> void:
	# Base chase movement
	if dead:
		return
	
	if chasing:
		velocity = move_direction * move_speed

	# Add separation so enemies don't overlap
		velocity += get_separation_vector() * separation_strength
	else:
		velocity = Vector2.ZERO

	# Move properly with sliding + collision response
	move_and_slide()

	update_animation_parameters(velocity.normalized())
	pick_new_state()
	
	if Global.st_man_dead == true:
		dead = true


func get_separation_vector() -> Vector2:
	var force := Vector2.ZERO

	for other in get_tree().get_nodes_in_group("static_man"):
		if other == self:
			continue

		var dist := global_position.distance_to(other.global_position)
		if dist < separation_radius and dist > 0:
			force += (global_position - other.global_position).normalized() * (separation_radius - dist)

	return force


func move_to_player():
	#chasing = true
	move_direction = to_local(nav_agent.get_next_path_position()).normalized()


func update_animation_parameters(move_dir : Vector2):
	if move_dir != Vector2.ZERO:
		animation_tree.set("parameters/move/blend_position", move_dir)
		animation_tree.set("parameters/awake/blend_position", move_dir)
		animation_tree.set("parameters/death/blend_position", move_dir)
		animation_tree.set("parameters/asleep/blend_position", move_dir)


func pick_new_state():
	if velocity.length() > 1:
		state_machine.travel("move")
	#if dead == true:
		#velocity = Vector2.ZERO
		#state_machine.travel("death")
		#await animation_tree.animation_finished
		#dead = false
		#Global.st_man_dead = false
		#queue_free()

func st_man():
	pass

func die():
	if dead == true:
		return
	collision_shape_2d.set_deferred("disabled", true)
	dead = true
	velocity = Vector2.ZERO
	state_machine.travel("death")
	await animation_tree.animation_finished
	Global.max_st_man -=1
	queue_free()

func makepath() -> void:
	nav_agent.target_position = player.global_position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player") and dead != true:
		get_tree().change_scene_to_file("res://scenes/nightmare/death_screen/static_man/death_static_man.tscn")


func _on_timercrow_timeout() -> void:
	makepath()
	move_to_player()


func _on_timer_awake_timeout() -> void:
	chasing = true
