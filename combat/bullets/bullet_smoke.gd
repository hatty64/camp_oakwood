extends CharacterBody2D

@export var speed : float = 100
@export var target : CharacterBody2D = null

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var move_direction : Vector2 = Vector2.ZERO
var dir : float
var spawn_pos : Vector2

func _ready() -> void:
	sprite_2d.play("default")
	global_position = spawn_pos
	
	

func _physics_process(delta: float) -> void:
	move_direction = Vector2(target.position.x, target.position.y)
	velocity = move_direction * speed
	move_and_slide()
