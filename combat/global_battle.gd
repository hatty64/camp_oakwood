extends Node

var enemies_turns = false
var enemies_left : int :
	set(value):
		enemies_left = clamp(value, 0, 3)
var max_enemies = 3
var player_turns = 2

var christina_finished = false
var woodling_finished = false

var player_attacking = false
var player_casting = false

var enemy_damage = false

var enemy_dead = false
var player_dead = false

#var enemy_attack = false
#var player_attack = false

const GAME_SIZE: Vector2 = Vector2(1920, 1080)
const GAME_SIZE_HALVED: Vector2 = GAME_SIZE * 0.5
const CELL_SIZE: Vector2 = Vector2(32,32)
const NULL_CELL: Vector2 = Vector2(-9999,-9999)


var cursor: Node = null
var camera: Camera2D = null
var cell_size: Vector2 = Vector2(0, 0)
var event_log: Label = null
var menu_has_focus: bool = false

func _ready():
	randomize()
