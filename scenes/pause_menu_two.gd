extends Control

@onready var animation_player := $AnimationPlayer
@onready var color_rect = $ColorRect
@onready var map_button = $notebook_open_full/VBoxContainer/map
@onready var barleys_office = $notebook_map_open_full/barleys_office
@onready var christina = $"../.."
@onready var resume_but = $notebook_open_full/VBoxContainer/resume
@onready var map_but = $notebook_open_full/VBoxContainer/map
@onready var quit_but = $notebook_open_full/VBoxContainer/quit
@onready var notebook_open_full = $notebook_open_full

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
	christina.input_vector = Vector2.ZERO
	color_rect.show()
	animation_player.play("notebook_opening")
	await animation_player.animation_finished

func map():
	animation_player.play("turn_to_map")
	await animation_player.animation_finished

func back_map():
	animation_player.play("map_to_menu")
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




func _on_map_pressed():
	map()


func _on_back_pressed():
	back_map()











func _on_color_rect_mouse_entered():
	barleys_office.show()


func _on_color_rect_mouse_exited():
	barleys_office.hide()
