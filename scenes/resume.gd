extends TextureButton
@onready var notebook_open_full = $"../.."
@onready var map = $"../map"
@onready var quit = $"../quit"

func _ready():
	if Global.got_map == false:
		focus_neighbor_bottom = get_path_to(quit)
	else:
		focus_neighbor_bottom = get_path_to(map)



func _on_notebook_open_full_visibility_changed():
	grab_focus()
