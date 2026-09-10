extends CharacterBody2D
class_name MushroomEnemy

var sleep = false

func _ready() -> void:
	add_to_group("mushroom")
	#makepath()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	if sleep:
		return
	
	if sleep == true:
		print("sleeping")

func sleeping():
	if sleep:
		return
	sleep = true
