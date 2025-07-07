extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect
@onready var map_button = $notebook_open_full/VBoxContainer/map
@onready var barleys_office = $notebook_map_open_full/barleys_office
@onready var christina = $"../.."
@onready var resume_but = $notebook_open_full/VBoxContainer/resume
@onready var map_but = $notebook_open_full/VBoxContainer/map
@onready var quit_but = $notebook_open_full/VBoxContainer/quit
@onready var notebook_open_full = $notebook_open_full
@onready var check_default: Area2D = $notebook_costume_open_full/VBoxContainer/Default/check_default
@onready var check_raincoat: Area2D = $notebook_costume_open_full/VBoxContainer/raincoat/check_raincoat
@onready var texture_rect: TextureRect = $notebook_costume_open_full/VBoxContainer3/TextureRect
@onready var raincoat_but: TextureButton = $notebook_costume_open_full/VBoxContainer/raincoat
@onready var check_onesie: Area2D = $notebook_costume_open_full/VBoxContainer/onesie/check_onesie
@onready var onesie_but: TextureButton = $notebook_costume_open_full/VBoxContainer/onesie
@onready var dark_but: TextureButton = $notebook_costume_open_full/VBoxContainer/dark
@onready var check_dark: Area2D = $notebook_costume_open_full/VBoxContainer/dark/check_dark
@onready var check_woodling: Area2D = $notebook_costume_open_full/VBoxContainer/woodling/check_woodling
@onready var woodling_but: TextureButton = $notebook_costume_open_full/VBoxContainer/woodling


func _ready():
	animation_player.speed_scale = 1.5
	animation_player.play("RESET")

func resume():
	animation_player.play("notebook_closing")
	await animation_player.animation_finished
	color_rect.hide()
	get_tree().paused = false

func pause():
	get_tree().paused = true
	#christina.input_vector = Vector2.ZERO
	color_rect.show()
	animation_player.play("notebook_opening")
	await animation_player.animation_finished

func map():
	animation_player.play("turn_to_map")
	await animation_player.animation_finished

func costumes():
	animation_player.play("turn_to_costume")
	await animation_player.animation_finished

func back_map():
	animation_player.play("map_to_menu")
	await animation_player.animation_finished

func back_costume():
	animation_player.play("costume_to_menu")
	await animation_player.animation_finished

func testEsc():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()



func _on_resume_pressed():
	resume()



func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	if Global.input_blocked != true:
		testEsc()
	if Global.got_map == true:
		map_but.disabled = false
	else:
		map_but.disabled = true
	if GlobalCostume.default == true:
		check_default.visible = true
		check_raincoat.visible = false
		check_onesie.visible = false
		check_dark.visible = false
		check_woodling.visible = false
	elif GlobalCostume.raincoat == true:
		check_default.visible = false
		check_raincoat.visible = true
		check_onesie.visible = false
		check_dark.visible = false
		check_woodling.visible = false
	elif GlobalCostume.onesie == true:
		check_default.visible = false
		check_raincoat.visible = false
		check_onesie.visible = true
		check_dark.visible = false
		check_woodling.visible = false
	elif GlobalCostume.dark == true:
		check_default.visible = false
		check_raincoat.visible = false
		check_onesie.visible = false
		check_dark.visible = true
		check_woodling.visible = false
	elif GlobalCostume.woodling == true:
		check_default.visible = false
		check_raincoat.visible = false
		check_onesie.visible = false
		check_dark.visible = false
		check_woodling.visible = true
	
	if GlobalCostume.raincoat_unlocked == false:
		raincoat_but.disabled = true
	else:
		raincoat_but.disabled = false
	if GlobalCostume.onesie_unlocked == false:
		onesie_but.disabled = true
	else:
		onesie_but.disabled = false
	if GlobalCostume.dark_unlocked == false:
		dark_but.disabled = true
	else:
		dark_but.disabled = false
	if GlobalCostume.woodling_unlocked == false:
		woodling_but.disabled = true
	else:
		woodling_but.disabled = false




func _on_map_pressed():
	map()


func _on_back_pressed():
	back_map()



func _on_costumes_pressed() -> void:
	costumes()

func _on_back_2_pressed() -> void:
	back_costume()





#func _on_color_rect_mouse_entered():
	#barleys_office.show()
#
#
#func _on_color_rect_mouse_exited():
	#barleys_office.hide()


func _on_raincoat_pressed() -> void:
	GlobalCostume.default = false
	GlobalCostume.raincoat = true
	GlobalCostume.onesie = false
	GlobalCostume.dark = false
	GlobalCostume.woodling = false


func _on_default_pressed() -> void:
	GlobalCostume.default = true
	GlobalCostume.raincoat = false
	GlobalCostume.onesie = false
	GlobalCostume.dark = false
	GlobalCostume.woodling = false

func _on_onesie_pressed() -> void:
	GlobalCostume.default = false
	GlobalCostume.raincoat = false
	GlobalCostume.onesie = true
	GlobalCostume.dark = false
	GlobalCostume.woodling = false

func _on_dark_pressed() -> void:
	GlobalCostume.default = false
	GlobalCostume.raincoat = false
	GlobalCostume.onesie = false
	GlobalCostume.dark = true
	GlobalCostume.woodling = false

func _on_woodling_pressed() -> void:
	GlobalCostume.default = false
	GlobalCostume.raincoat = false
	GlobalCostume.onesie = false
	GlobalCostume.dark = false
	GlobalCostume.woodling = true


func _on_default_focus_entered() -> void:
	texture_rect.texture = load("res://textures/default_icon.png")



func _on_raincoat_focus_entered() -> void:
	if GlobalCostume.raincoat_unlocked == true:
		texture_rect.texture = load("res://textures/raincoat_icon.png")
	else:
		texture_rect.texture = null



func _on_onesie_focus_entered() -> void:
	if GlobalCostume.onesie_unlocked == true:
		texture_rect.texture = load("res://textures/onesie_icon.png")
	else:
		texture_rect.texture = null



func _on_dark_focus_entered() -> void:
	if GlobalCostume.dark_unlocked == true:
		texture_rect.texture = load("res://textures/dark_icon.png")
	else:
		texture_rect.texture = null


func _on_woodling_focus_entered() -> void:
	if GlobalCostume.woodling_unlocked == true:
		texture_rect.texture = load("res://textures/woodling_icon.png")
	else:
		texture_rect.texture = null
