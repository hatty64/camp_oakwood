extends CanvasModulate

@onready var rain = $"../rain"
@onready var sunset = $"."

func _process(delta):
	if Global.sunset == true:
		sunset.show()
		rain.hide()
	else:
		sunset.hide()
