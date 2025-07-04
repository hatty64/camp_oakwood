extends CharacterBody2D


@export var move_speed : float = 65
@export var dash_speed : float = 95
@export var starting_direction : Vector2 = Vector2(0, 1)

#parameters/idle/blend_position
#parameters/walk/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var night_vision_module: CanvasModulate = $CanvasModulate
@onready var rain_modulate: CanvasModulate = $"../rain/CanvasModulate"
@onready var sunset_modulate: CanvasModulate = $"../sunset"
@onready var canvas_layer_2: CanvasLayer = $CanvasLayer2

var input_vector: Vector2 = Vector2.ZERO

var deadzone_input = 0.5
var deadzone_move = 0.32

var move_dir = Vector2.ZERO

var dashing = false

var can_dash = true

func _ready():
	InputMap.action_set_deadzone("left", deadzone_input)
	InputMap.action_set_deadzone("right", deadzone_input)
	InputMap.action_set_deadzone("up", deadzone_input)
	InputMap.action_set_deadzone("down", deadzone_input)
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	if not Global.input_blocked:
		handle_player_input()
	
	if Input.is_action_just_pressed("sprint") and can_dash:
		dashing = true
		can_dash = false
		$dash_timer.start()
		$can_dash_timer.start()
	

#func _process(delta: float) -> void:
	#if Vector2.ZERO.distance_to(input_vector) > deadzone_move*sqrt(2.0):
		#move_dir = input_vector.normalized()
	#else:
		#move_dir = Vector2.ZERO


func handle_player_input():
	var input_direction = Vector2(
	Input.get_action_strength("right") - Input.get_action_strength("left"),
	Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	update_animation_parameters(input_direction)
	
	
	if dashing == true:
		velocity = input_direction.normalized() * dash_speed
	else:
		velocity = input_direction.normalized() * move_speed
	
	
	
	move_and_slide()
	
	pick_new_state()


func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/move/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)
		animation_tree.set("parameters/dash/blend_position", move_input)


func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("move")
	if dashing == true:
		state_machine.travel("dash")
	if velocity == Vector2.ZERO:
		state_machine.travel("idle")



func player():
	pass



#func _unhandled_input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("accept"):
		#var actionables = actionable_finder.get_overlapping_areas()
		#if actionables.size() > 0:
			#GlobalDays.start_dialogue()
			#$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
			#state_machine.travel("idle")
			#actionables[0].action()
			#input_vector = Vector2.ZERO
			#await DialogueManager.dialogue_ended
			#$Camera2D.toggle_cinematic(false)
			#GlobalDays.end_dialogue()
			#return

#func get_mirrored_frame():
	#var frame = $Sprite2D.frame
	#
	#if frame < 4 or frame > 7 and frame < 12:
		#return frame + 4
		#
	#return frame - 4


func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_can_dash_timer_timeout() -> void:
	can_dash = true
