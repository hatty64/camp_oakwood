extends Node2D

var time_til_explode := 0.1
var ex_mushroom = preload("res://combat/bullets/exploding_mushrooms.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time_til_explode -= delta
	if time_til_explode < 0.0:
		time_til_explode = randf_range(1, 0.5)
		var newMushroom = ex_mushroom.instantiate()
		newMushroom.position = Vector2(randf_range(-124, 124), randf_range(-59, 68))
		add_child(newMushroom)
