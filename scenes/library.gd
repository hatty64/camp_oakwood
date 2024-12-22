extends Node2D



var pet = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$librarian/AnimationPlayer_librarian.play("librarian")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pet == true:
		if Input.is_action_just_pressed("accept"):
			$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
			$AnimationPlayer.play("spot_pet")
			$spot/Area2D/CollisionShape2D.disabled = true
			await get_tree().create_timer(3.0).timeout
			$spot/Area2D/CollisionShape2D.disabled = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		pet = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		pet = false
