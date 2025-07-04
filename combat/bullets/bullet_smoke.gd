extends PathFollow2D
@onready var regular_mushroom_combat: CharacterBody2D = $"../.."

var speed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if regular_mushroom_combat.bullet_move == true:
		visible = true
		progress_ratio += delta * speed
	
	if loop == false and get_progress_ratio() == 1:
		queue_free()
