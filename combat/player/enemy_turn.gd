extends Node2D

@export var fighting_background: Texture2D = null

@onready var battle_bg: Sprite2D = $StaticBody2D/battleBG

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_bg.texture = fighting_background


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
