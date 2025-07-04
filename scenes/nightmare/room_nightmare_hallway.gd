extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		$StaticBody2D/AnimationPlayer.play("move")
		await $StaticBody2D/AnimationPlayer.animation_finished
		$Area2D/CollisionShape2D.disabled = true
		$Area2D.monitoring = false
