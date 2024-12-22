extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	testEsc()

func testEsc():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()


func pause():
	get_tree().paused = true
	#christina.input_vector = Vector2.ZERO
	$".".show()

func resume():
	$".".hide()
	get_tree().paused = false


func _on_visibility_changed() -> void:
	$continue.grab_focus()


func _on_continue_pressed() -> void:
	resume()
