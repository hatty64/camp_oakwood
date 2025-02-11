extends Node2D



var pet = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.sprint_blocked = true
	if Global.loadin_library == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, 1))
		$Christina.position.x = 921
		$Christina.position.y = 458
	else:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
	$librarian/AnimationPlayer_librarian.play("librarian")

var entered = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if entered == true:
		Transit.change_scene_to_file("res://scenes/library_top_floor.tscn")
		Global.loadin_library_top = true
		Global.loadin_library = false
	
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


func _on_top_floor_transit_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true


func _on_top_floor_transit_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false
