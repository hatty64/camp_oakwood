extends CharacterBody2D

@export var move_speed : float = 200

var move_direction : Vector2 = Vector2.ZERO

var target_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../AnimationPlayer".play("idle")
	stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if move_direction != Vector2.ZERO:
		var to_target = target_position - position
		var direction = (target_position - position).normalized()
		velocity = direction * move_speed
		
		if to_target.length() < 2:
			move_direction = Vector2.ZERO
			velocity = Vector2.ZERO
			return
		
	else:
		velocity = Vector2.ZERO
	
	
	#position.x = clamp(position.x, -58.0, 58.0)
	#position.y = clamp(position.y, -63.0, 63.0)
	
	move_and_slide()

func move():
	move_direction = Vector2.ONE
	target_position = Vector2(
	randf_range(-88, 88),
	randf_range(-32, -95)
	)
	print(position)
	$"../Timer".wait_time = 0.5
	$"../Timer".start()
	await $"../Timer".timeout
	$"../Timer".stop()
	stop()

func stop():
	$"../Timer".wait_time = 1
	move_direction = Vector2.ZERO
	$"../Timer".start()
	await $"../Timer".timeout
	$"../Timer".stop()
	attack()

func attack():
	move_direction = Vector2.ZERO
	$"../AnimationPlayer".play("attack")
	await $"../AnimationPlayer".animation_finished
	$"../AnimationPlayer".play("idle")
	move()
