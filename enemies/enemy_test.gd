extends Node2D

var flicker = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#light_off()

func  _physics_process(delta: float) -> void:
	if Global.lights_on == false:
		$CanvasModulate.visible = true
	else:
		$CanvasModulate.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.




func light_off():
	$Timer.wait_time = 2
	$Timer.start()
	await $Timer.timeout
	$Timer.stop()
	Global.lights_on = false
	light_on()

func light_on():
	$Timer.wait_time = 3
	$Timer.start()
	await $Timer.timeout
	$Timer.stop()
	Global.lights_on = true
	light_off()
