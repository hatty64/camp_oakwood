extends CanvasLayer


var filling_up = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if $TextureProgressBar.value < 100 and Global.sprinting == false:
		$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.sprinting == true and $"../Christina".velocity != Vector2.ZERO:
		$TextureProgressBar.value -= 1
	
	if $TextureProgressBar.value <= 0:
		Global.sprint_blocked = true
		Global.sprinting = false
		$"../Christina".move_speed = 65
	else:
		Global.sprint_blocked = false
	
	if filling_up == true:
		$TextureProgressBar.value += 0.5
	
	if $TextureProgressBar.value >= 100:
		filling_up = false


func _on_timer_timeout() -> void:
	filling_up = true
