extends Sprite2D

@export var health: int = 30
@export var attack: int = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalBattle.enemy_dead == false:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("damage_or_dead")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
