extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.hide()
	$AnimationPlayer.play("fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hold_to_skip()
	


func hold_to_skip():
	if Input.is_action_pressed("pause"):
		$ProgressBar.show()
		$ProgressBar.value += 1
	else:
		$ProgressBar.value -= 1
	
	if $ProgressBar.value == 0:
		$ProgressBar.hide()
