extends TextureButton
@onready var resume = $"../resume"
@onready var map = $"../map"


func _ready():
	if Global.got_map == false:
		focus_neighbor_top = get_path_to(resume)
	else:
		focus_neighbor_top = get_path_to(map)
