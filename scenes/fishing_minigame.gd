extends Node2D

@onready var progress_bar = $ProgressBar
@onready var timer = $Timer
@onready var christina_fish_anim = $christina_fish/AnimationPlayer
@onready var fish_minigame_ui = $CanvasLayer/fish_minigame_ui

func _ready():
	timer.start()

func _process(delta):
	reel_fish()
	fish_caught()
	fish_got_away()
	finish_minigame()


func _on_timer_timeout():
	christina_fish_anim.play("lost_grip")
	progress_bar.value -= 2

func reel_fish():
	if Input.is_action_just_pressed("reel_fish"):
		christina_fish_anim.play("reel_in")
		progress_bar.value += 1

func fish_caught():
	if progress_bar.value == 100:
		christina_fish_anim.play("fish_caught")
		timer.stop()
		get_tree().paused = true
		
		#print("You caught fish, yay")

func fish_got_away():
	if progress_bar.value == 0:
		christina_fish_anim.play("fish_not_caught")
		timer.stop()
		get_tree().paused = true

func finish_minigame():
	if get_tree().paused == true:
		fish_minigame_ui.show()
	else:
		fish_minigame_ui.hide()


func _on_restart_pressed():
	progress_bar.value = 50
	timer.start()
	get_tree().paused = false

func _on_quit_pressed():
	get_tree().quit()
