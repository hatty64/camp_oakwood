extends Node2D
class_name mirror

@export var character: Node

func _process(delta):
	var distance_y = character.global_position.y - global_position.y
	_update_mirror_position(distance_y)
	_update_mirror_frame()



func _update_mirror_position(distance_y):
	$dark_christina.global_position = Vector2(
		character.global_position.x,
		global_position.y - distance_y
	)
	$DarkChristinaTransform.global_position = Vector2(
		character.global_position.x,
		global_position.y - distance_y
	)

func _update_mirror_frame():
	$dark_christina.frame = character.get_mirrored_frame()
