extends Node2D

@export var attacking = false


var bullets = preload("res://combat/bullets/bullet_smoke.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody2D.position.y = -54


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if attacking == true:
		var newBullet = bullets.instantiate()
		newBullet.position = $CharacterBody2D.position
		add_child(newBullet)
		attacking = false
