extends CharacterBody2D
@export var starting_direction : Vector2 = Vector2(0, 1)

const SPEED = 65

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var input_vector: Vector2 = Vector2.ZERO


func _ready() -> void:
	animation_tree.active = true
	animation_tree.set("parameters/idle/blend_position", starting_direction)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			input_vector = Vector2.ZERO
			return

	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	if x_axis:
		input_vector = x_axis * Vector2.RIGHT
	elif y_axis:
		input_vector = y_axis * Vector2.DOWN
	else:
		input_vector = Vector2.ZERO


func _physics_process(_delta):
	if input_vector.length() > 0:
		velocity = input_vector * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()

	if velocity.length() > 0:
		animation_tree.set("parameters/idle/blend_position", velocity)
		animation_tree.set("parameters/walk/blend_position", velocity)
		animation_tree.get("parameters/playback").travel("walk")
	else:
		animation_tree.get("parameters/playback").travel("idle")



func player():
	pass


func get_mirrored_frame():
	var frame = $Sprite2D.frame
	
	if frame < 4 or frame > 7 and frame < 12:
		return frame + 4
		
	return frame - 4

#func current_camera():
	#if global.current_scene == "world1":
		#$world1_camera.enabled = true
		#$world2_camera.enabled = false
	#elif global.current_scene == "world2":
		#$world1_camera.enabled = false
		#$world2_camera.enabled = true
