extends TextureButton

@export var data: BattleActor = null : 
	set(value):
		data = value.copy()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_focus_entered() -> void:
	animation_player.play("focus")


func _on_focus_exited() -> void:
	animation_player.play("RESET")
