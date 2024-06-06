extends Node

var next_world

@onready var current_world = $world1
@onready var anim = $AnimationPlayer

func _ready() -> void:
	current_world.connect("change_scene", self, "handle_world_change")
