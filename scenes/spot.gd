extends CharacterBody2D




func _ready() -> void:
	pass

#func _process(delta: float) -> void:
	#



func _on_area_2d_body_entered(body: Node2D) -> void:
	if Input.is_action_just_pressed("accept"):
		$"../AnimationPlayer".play("spot_pet")
		$Area2D/CollisionShape2D.disabled = true
		await get_tree().create_timer(5.0).timeout
		$Area2D/CollisionShape2D.disabled = false
