extends CharacterBody2D


@export var move_speed : float = 2.4

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

@onready var player = $"../Christina"
var move_direction : Vector2 = Vector2.ZERO

var chasing = false

func _ready() -> void:
	makepath()

func _physics_process(delta: float) -> void:
	
	if Global.lights_on == false:
		chasing = true
		move_direction = to_local(nav_agent.get_next_path_position()).normalized()
		#move_direction = (player.position - position).normalized()
	else:
		move_direction = Vector2.ZERO
	
	velocity = move_direction * move_speed
	
	update_animation_parameters(move_direction)
	
	#move_to_player()
	
	pick_new_state()
	
	move_and_collide(velocity)

func move_to_player():
	if Global.lights_on == false:
		chasing = true
		move_direction += (player.position - position)

func update_animation_parameters(move_dir : Vector2):
	if(move_dir != Vector2.ZERO):
		animation_tree.set("parameters/move/blend_position", move_dir)
		animation_tree.set("parameters/idle/blend_position", move_dir)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("move")
	if (velocity == Vector2.ZERO):
		state_machine.travel("idle")

func makepath() -> void:
	nav_agent.target_position = player.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://scenes/nightmare/death_screen/scarecrow/death_scarecrow.tscn")


func _on_timercrow_timeout() -> void:
	makepath()
