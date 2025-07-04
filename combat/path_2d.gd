extends Path2D

@onready var regular_mushroom_combat: CharacterBody2D = $".."
@onready var bullet_smoke: PathFollow2D = $bullet_smoke

var rng = RandomNumberGenerator.new()

var bullet_amount = 0

var normal_bullets = preload("res://combat/bullets/bullet_smoke.tscn")

#var more_bullets = [
	#preload("res://combat/bullets/bullet_smoke.tscn"),
	#preload("res://combat/bullets/bullet_smoke_parry.tscn")
#]
var parry_bullets = preload("res://combat/bullets/bullet_smoke_parry.tscn")

#var bullets = rng.randi_range(0, 1)

var weight = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if regular_mushroom_combat.spawn_bullet == true:
		#var b = randi() % more_bullets.size()
		var newBullet = normal_bullets.instantiate()
		var newParry = parry_bullets.instantiate()
		
		if bullet_amount <= 3:
			add_child(newBullet)
			bullet_amount += 1
		if bullet_amount == 3:
			add_child(newParry)
			bullet_amount = 0
		regular_mushroom_combat.spawn_bullet = false
