extends StaticBody2D
@onready var rain: StaticBody2D = $"."
@onready var tile_map: TileMap = $"../TileMap"

func _process(delta: float) -> void:
	if rain.visible != true:
		tile_map.set_layer_enabled(7, false)
