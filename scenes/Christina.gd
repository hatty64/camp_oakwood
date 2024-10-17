extends CharacterBody2D

@export var move_speed : float = 65
@export var starting_direction : Vector2 = Vector2(0, 1)

#parameters/idle/blend_position
#parameters/walk/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var input_vector: Vector2 = Vector2.ZERO

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	if not Global.input_blocked:
		handle_player_input()
	


func handle_player_input():
	var input_direction = Vector2(
	Input.get_action_strength("right") - Input.get_action_strength("left"),
	Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	update_animation_parameters(input_direction)
	
	sprinting()
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	pick_new_state()


func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)
		animation_tree.set("parameters/run/blend_position", move_input)


func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	if move_speed == 110 and velocity != Vector2.ZERO:
		state_machine.travel("run")
	if velocity == Vector2.ZERO:
		state_machine.travel("idle")

func sprinting():
	if Global.sprint_blocked != true:
		if Input.is_action_pressed("sprint"):
			move_speed = 110
		else:
			move_speed = 65


func player():
	pass



func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			GlobalDays.start_dialogue()
			state_machine.travel("idle")
			actionables[0].action()
			input_vector = Vector2.ZERO
			await DialogueManager.dialogue_ended
			GlobalDays.end_dialogue()
			return

func get_mirrored_frame():
	var frame = $Sprite2D.frame
	
	if frame < 4 or frame > 7 and frame < 12:
		return frame + 4
		
	return frame - 4
