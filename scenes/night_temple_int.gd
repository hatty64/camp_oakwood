extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.sprint_blocked = true
	$Christina/AnimationTree.set("parameters/idle/blend_position", Vector2(0, -1))

var entered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if entered == true:
		Transit.change_scene_to_file("res://scenes/night_temple_int_cutscene.tscn")


func _on_cutscene_transit_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true


func _on_cutscene_transit_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false
