extends Control


func _ready():
	hide()

func _input(event: InputEvent):
	if event.is_action_pressed("pause"):
		hide()

func _on_quit_pressed():
	show()


func _on_yes_pressed():
	get_tree().quit()


func _on_no_pressed():
	hide()
