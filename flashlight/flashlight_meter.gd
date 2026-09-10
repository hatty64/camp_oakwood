extends Control

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer
@onready var texture_rect: TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_progress_bar.visible = false
	texture_progress_bar.value = 0
	texture_rect.visible = false

func _physics_process(delta: float) -> void:
	battery_power()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.flashlight_unlocked == true:
		if Global.flashlight_disabled != true:
			if Input.is_action_pressed("flashlight"):
				Global.flashlighting = true
				texture_progress_bar.visible = true
				texture_progress_bar.value += 1
			else:
				Global.flashlighting = false
				texture_progress_bar.visible = false
				texture_progress_bar.value = 0
		else:
			texture_progress_bar.visible = false
			texture_progress_bar.value = 0
	
	if texture_progress_bar.value >= 150:
		Global.flitsable = true
	else:
		Global.flitsable = false


func battery_power():
	if Global.battery_percentage == 3:
		timer.start()
		texture_rect.texture = load("res://textures/battery/battery_full.png")
	elif Global.battery_percentage == 2:
		timer.start()
		texture_rect.texture = load("res://textures/battery/battery_half.png")
	elif Global.battery_percentage == 1:
		timer.start()
		texture_rect.texture = load("res://textures/battery/battery_almost_empty.png")
	else:
		timer.start()
		texture_rect.texture = load("res://textures/battery/battery_empty.png")
	
	


func _on_timer_timeout() -> void:
	texture_rect.visible = false
