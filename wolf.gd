extends CharacterBody2D


const SPEED = 20.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		
	change_wolf()
	if velocity != Vector2.ZERO:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("left", "right")
	var directiony := Input.get_axis("up", "down")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Input.is_action_pressed("left"):
		$Sprite2D.flip_h = false
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = true

	move_and_slide()


func change_wolf():
	if Global.hunted_1 == true:
		$Sprite2D.texture = load("res://character_sprite/minigame/wolf_2.png")
	elif Global.hunted_2 == true:
		$Sprite2D.texture = load("res://character_sprite/minigame/wolf_3.png")
	else:
		$Sprite2D.texture = load("res://character_sprite/minigame/wolf.png")
