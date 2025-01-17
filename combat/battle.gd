extends Node2D

@export var world : PackedScene

var christina_hover = true
var partner_hover = false
var christina_selected = false
var partner_selected = false

var chr_select = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$christina_menu.visible = false
	$partner_menu.visible = false
	get_tree().paused = false
	$christina_battle/AnimationPlayer.play("idle")
	await get_tree().create_timer(1.0).timeout
	chr_select = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("up"):
		#$CharacterBody2D/AnimationPlayer.play("idle")
	#if Input.is_action_just_pressed("right"):
		#$CharacterBody2D/AnimationPlayer.play("punch")
	#if Input.is_action_just_pressed("down"):
		#$CharacterBody2D/AnimationPlayer.play("low_health")
	#if Input.is_action_just_pressed("left"):
		#$CharacterBody2D/AnimationPlayer.play("victory")
	
	choose_character()
	
	if christina_selected == true:
		$christina_menu.visible = true
		$partner_menu.visible = false
	elif partner_selected == true:
		$christina_menu.visible = false
		$partner_menu.visible = true
	
	if christina_hover == true:
		$CharacterSelect.position.x = 538
		$CharacterSelect.position.y = 426
	elif partner_hover == true:
		$CharacterSelect.position.x = 522
		$CharacterSelect.position.y = 388
		
	
	if chr_select == true:
		$CharacterSelect.visible = true
	else:
		$CharacterSelect.visible = false


func _on_button_pressed() -> void:
	BattleTransition.change_packed_scene(world)


func choose_character():
	if Input.is_action_just_pressed("up") and chr_select == true:
		christina_hover = false
		partner_hover = true
	if Input.is_action_just_pressed("down") and chr_select == true:
		christina_hover = true
		partner_hover = false
	
	if Input.is_action_just_pressed("accept") and christina_hover == true:
		christina_selected = true
		partner_selected = false
		#christina_hover = false
		#partner_hover = false
		chr_select = false
	elif Input.is_action_just_pressed("accept") and partner_hover == true:
		christina_selected = false
		partner_selected = true
		#christina_hover = false
		#partner_hover = false
		chr_select = false
	
	if Input.is_action_just_pressed("back") and chr_select == false:
		chr_select = true
		christina_selected = false
		partner_selected = false
		$christina_menu.visible = false
		$partner_menu.visible = false
		$partner_menu/HBoxContainer/Cast.release_focus()
		$christina_menu/HBoxContainer/Attack.release_focus()





func _on_partner_menu_visibility_changed() -> void:
	$partner_menu/HBoxContainer/Cast.grab_focus()


func _on_christina_menu_visibility_changed() -> void:
	$christina_menu/HBoxContainer/Attack.grab_focus()
