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
@onready var texture_progress_bar: TextureProgressBar = $CanvasLayer/flashlight_meter/TextureProgressBar
@onready var timer: Timer = $Timer
@onready var texture_rect: TextureRect = $CanvasLayer/flashlight_meter/TextureRect
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var flash: DirectionalLight2D = $Flash
@onready var timer_flash: Timer = $TimerFlash
@onready var animation_player_flash: AnimationPlayer = $Flash/AnimationPlayerFlash
@onready var collision_polygon_2d: CollisionPolygon2D = $PointLight2D/Area2D/CollisionPolygon2D


var input_vector: Vector2 = Vector2.ZERO

var deadzone_input = 0.5
var deadzone_move = 0.32

var move_dir = Vector2.ZERO

var dialoging = false

func _ready():
	#InputMap.action_set_deadzone("left", deadzone_input)
	#InputMap.action_set_deadzone("right", deadzone_input)
	#InputMap.action_set_deadzone("up", deadzone_input)
	#InputMap.action_set_deadzone("down", deadzone_input)
	update_animation_parameters(starting_direction)
	point_light_2d.visible = false
	collision_polygon_2d.disabled = true
	animation_player_flash.play("RESET")

func _input(event: InputEvent) -> void:
	if Global.flashlight_unlocked == true:
		flashlight()

func _physics_process(_delta):
	if not Global.input_blocked:
		handle_player_input()
	costume_change()
	night_vision()
	if Input.is_action_just_pressed("reload_flashlight") and Global.flashlight_unlocked == true:
		texture_rect.visible = true
		timer.start()
		Global.battery_percentage = 3

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
	
	update_speed()
	
	if Global.flashlighting == true:
		point_light_2d.visible = true
	else:
		point_light_2d.visible = false
	
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	pick_new_state()


func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)
		animation_tree.set("parameters/run/blend_position", move_input)
		animation_tree.set("parameters/fl_idle/blend_position", move_input)
		animation_tree.set("parameters/fl_walk/blend_position", move_input)


func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	if move_speed >= 110 and velocity != Vector2.ZERO:
		state_machine.travel("run")
	if velocity == Vector2.ZERO:
		state_machine.travel("idle")
	
	
	if Global.flashlighting == true and velocity != Vector2.ZERO:
		state_machine.travel("fl_walk")
	elif Global.flashlighting == true and velocity == Vector2.ZERO:
		state_machine.travel("fl_idle")

func sprinting():
	if Global.sprint_blocked != true:
		if Input.is_action_pressed("sprint") and not Global.flashlighting:
			Global.sprinting = true
			move_speed = 130
		else:
			Global.sprinting = false
			move_speed = 75

func flashlight():
	if Global.flitsable == true:
		point_light_2d.texture = load("res://textures/battery/light_full.png")
		print("FLASHLIGHT")
	else:
		point_light_2d.texture = load("res://textures/battery/light.png")
	
	if Global.flitsable == true and Input.is_action_just_released("flashlight"):
		#input_vector = Vector2.ZERO
		#state_machine.travel("idle")
		#GlobalDays.dazed()
		#Global.flashlight_disabled = true
		Global.flashlighting = false
		Global.battery_percentage -= 1
		texture_rect.visible = true
		collision_polygon_2d.disabled = false
		timer_flash.start()
		timer.start()
		animation_player_flash.play("flash")
		await animation_player_flash.animation_finished
		animation_player_flash.play("RESET")
	
	if Global.battery_percentage <= 0 or dialoging == true:
		Global.flashlight_disabled = true
	else:
		Global.flashlight_disabled = false
	

func player():
	pass

func update_speed():
	if Global.flashlighting:
		move_speed = 35
	elif Input.is_action_pressed("sprint") and not Global.sprint_blocked:
		move_speed = 130
	else:
		move_speed = 75


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if Global.flashlighting == true:
			return
		else:
			if actionables.size() > 0:
				GlobalDays.start_dialogue()
				dialoging = true
				$Camera2D.toggle_cinematic(HORIZONTAL_ALIGNMENT_CENTER)
				state_machine.travel("idle")
				actionables[0].action()
				input_vector = Vector2.ZERO
				await DialogueManager.dialogue_ended
				$Camera2D.toggle_cinematic(false)
				GlobalDays.end_dialogue()
				dialoging = false
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
		$Sprite2D.texture = load("res://character_sprite/color_outline/new_christina_full_sprite_flashlight.png")

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


func _on_timer_timeout() -> void:
	texture_rect.visible = false
	#Global.flashlight_disabled = false
	#GlobalDays.undazed()


func _on_timer_flash_timeout() -> void:
	collision_polygon_2d.disabled = true




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("static_man"):
		body.die()
	if body.is_in_group("mushroom"):
		print("body entered")
		body.sleeping()
