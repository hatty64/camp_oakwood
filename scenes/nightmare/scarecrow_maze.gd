extends Node2D


@onready var audio_stream : AudioStreamSynchronized = $AudioStreamPlayer.stream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.lights_on = true
	light_off()
	$CanvasModulate.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.lights_on == false:
		$CanvasModulate.color = "380255"
		audio_stream.set_sync_stream_volume(1, 0)
	else:
		$CanvasModulate.color = "830fc0"
		audio_stream.set_sync_stream_volume(1, -60)



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
