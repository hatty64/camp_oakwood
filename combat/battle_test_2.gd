extends Node2D

@onready var regular_mushroom_combat: CharacterBody2D = $regular_mushroom_combat
@onready var bullet_smoke: PathFollow2D = $regular_mushroom_combat/Path2D/bullet_smoke

var more_bullets = preload("res://combat/bullets/bullet_smoke.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if regular_mushroom_combat.bullet_move == true:
		#bullet_smoke.visible = true
		#bullet_smoke.progress_ratio += delta * bullet_smoke.speed
	#
	#if regular_mushroom_combat.spawn_bullet == true:
		#var newBullet = more_bullets.instantiate()
		#add_child(newBullet)
		#regular_mushroom_combat.spawn_bullet = false
