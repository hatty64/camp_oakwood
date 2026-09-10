extends Control

const Actions: Dictionary = EventQueue.Actions

var action: EventQueue.Actions = -1
var player_index: int = 0

@onready var options: Menu = $MarginContainer/options
@onready var enemies: Menu = $enemies
@onready var players: PlayerWindow = $MarginContainer/players
@onready var event_queue: EventQueue = $EventQueue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options.button_focus(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_options_button_pressed(button: BaseButton, _index: int) -> void:
	match button.name:
		"attack":
			action = Actions.ATTACK
			enemies.button_focus(0)
		_:
			pass


func _on_enemies_button_pressed(button: BaseButton, index: int) -> void:
	var actor: BattleActor = null
	var target: BattleActor = button.data
	event_queue.add(action, actor, target)
	print(target.actor_name, " HP: ", target.hp)
