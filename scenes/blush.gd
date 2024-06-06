extends Area2D

@onready var maya_sprite = $"../Sprite2D"
@onready var timer = $"../Timer"


func _on_body_entered(body):
	if body.has_method("player"): 
		maya_sprite.hframes = 1
		maya_sprite.vframes = 1
		maya_sprite.texture = load("res://character_sprite/maya_blush.png")



func _on_body_exited(body):
	if body.has_method("player"):
		maya_sprite.hframes = 4
		maya_sprite.vframes = 4
		maya_sprite.texture = load("res://character_sprite/maya_remake_full.png")
