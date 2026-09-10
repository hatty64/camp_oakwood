extends Area2D

@export var explode = false

var bullet_spread = preload("res://combat/bullets/bullet_spread.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("explode")
	await $AnimationPlayer.animation_finished
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if explode == true:
		var newSpread = bullet_spread.instantiate()
		newSpread.position = position
		add_child(newSpread)
		explode = false
