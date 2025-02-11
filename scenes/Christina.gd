extends CharacterBody2D

@export var move_speed : float = 65
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

var deadzone_input = 0.35
var deadzone_move = 0.32

var move_dir = Vector2.ZERO

func _ready():
	InputMap.action_set_deadzone("left", deadzone_input)
	InputMap.action_set_deadzone("right", deadzone_input)
	InputMap.action_set_deadzone("up", deadzone_input)
	InputMap.action_set_deadzone("down", deadzone_input)
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	if not Global.input_blocked:
		handle_player_input()
	costume_change()
	night_vision()
	

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
			$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
			state_machine.travel("idle")
			actionables[0].action()
			input_vector = Vector2.ZERO
			await DialogueManager.dialogue_ended
			$Camera2D.toggle_cinematic(false)
			GlobalDays.end_dialogue()
			return

func get_mirrored_frame():
	var frame = $Sprite2D.frame
	
	if frame < 4 or frame > 7 and frame < 12:
		return frame + 4
		
	return frame - 4

func costume_change():
	if GlobalCostume.raincoat == true:
		$Sprite2D.texture = load("res://character_sprite/christina_raincoat.png")
	elif GlobalCostume.onesie == true:
		$Sprite2D.texture = load("res://character_sprite/christina_onesie.png")
	elif GlobalCostume.dark == true:
		$Sprite2D.texture = load("res://character_sprite/christina_dark_costume.png")
	elif GlobalCostume.woodling == true:
		$Sprite2D.texture = load("res://character_sprite/christina_woodling.png")
	else:
		$Sprite2D.texture = load("res://character_sprite/color_outline/christina_color_outline.png")

func night_vision():
	if GlobalCostume.dark == true:
		if Input.is_action_pressed("night_vision"):
			$DirectionalLight2D.visible = true
			GlobalCostume.night_vision = true
			BGSPlayer.volume_db = -30.0
			MusicPlayer.volume_db = -30.0
		else:
			$DirectionalLight2D.visible = false
			GlobalCostume.night_vision = false
			BGSPlayer.volume_db = -10.0
			MusicPlayer.volume_db = -10.0
	elif GlobalCostume.dark == false:
		$DirectionalLight2D.visible = false
