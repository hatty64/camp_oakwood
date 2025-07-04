extends CharacterBody2D


@export var move_speed : float = 1.4

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var path: Path2D = $Path2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D

var last_position: Vector2
var loop_path: bool = true

@onready var player = $"../Christina"
var move_direction : Vector2 = Vector2.ZERO

var chasing = false

func _ready() -> void:
	#position = path_follow.global_position
	last_position = position
	pass

func _physics_process(delta: float) -> void:
	pass
	#path_follow.progress_ratio += move_speed * delta
	position = path_follow.global_position
	#
	var movement := position - last_position
	if movement.length() > 0.1:
		update_animation_parameters(movement)
	#
	#last_position = position
	
	#move_direction = (player.position - position).normalized()
	
	#velocity = move_direction * move_speed
	
	
	
	#move_to_player()
	
	pick_new_state()
	
	#move_and_collide(velocity)



func update_animation_parameters(move_dir : Vector2):
	if(move_dir != Vector2.ZERO):
		animation_tree.set("parameters/move/blend_position", move_dir)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("move")
