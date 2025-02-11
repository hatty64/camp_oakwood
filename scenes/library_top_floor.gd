extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.loadin_library_top == true:
		$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))
		$Christina.position.x = 922
		$Christina.position.y = 811

var entered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if entered == true:
		Transit.change_scene_to_file("res://scenes/library.tscn")
		Global.loadin_library = true
		Global.loadin_library_top = false



func _on_library_transit_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true


func _on_library_transit_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false
