extends Sprite2D

@export var health: int = 30
@export var attack: int = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalBattle.enemy_damage == true:
		$AnimationPlayer.play("damage")
		await $AnimationPlayer.animation_finished
		GlobalBattle.enemy_damage = false
		idle_or_dead()
	
	if health <= 0:
		GlobalBattle.enemy_dead = true
		GlobalBattle.enemies_left -= 1
	
	if GlobalBattle.enemies_left == 0:
		GlobalBattle.enemies_left -= 0
	
	#if GlobalBattle.enemies_turns == true:
		#visible = false
	#else:
		#visible = true

func idle_or_dead():
	if GlobalBattle.enemy_dead == false:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("dead")
		await $AnimationPlayer.animation_finished
		queue_free()
