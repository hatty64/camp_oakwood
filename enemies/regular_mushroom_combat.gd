extends CharacterBody2D

@onready var timer_attack_1: Timer = $timer_attack_1
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var spawn_bullet = false
@export var bullet_move = false

var enemies_turn = true

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if enemies_turn == true:
		animation_player.play("attack_1")
	else:
		animation_player.play("idle")
