extends Sprite2D

@onready var silhouette: Sprite2D = $silhouette

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	silhouette.texture = texture
	silhouette.offset = offset
	silhouette.flip_h = flip_h
	silhouette.hframes = hframes
	silhouette.vframes = vframes
	silhouette.frame = frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	##if Global.rain == true:
		##silhouette.visible = false
	##else:
		##silhouette.visible = true

func _set(property: StringName, value: Variant) -> bool:
	if is_instance_valid(silhouette):
		match property:
			"texture":
				silhouette.texture = value
			"offset":
				silhouette.offset = value
			"flip_h":
				silhouette.flip_h = value
			"hframes":
				silhouette.hframes = value
			"vframes":
				silhouette.vframes = value
			"frame":
				silhouette.frame = value
	return false
