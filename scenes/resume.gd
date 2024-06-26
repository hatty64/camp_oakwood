extends TextureButton
@onready var notebook_open_full = $"../.."
@onready var map = $"../map"
@onready var quit = $"../quit"








func _on_notebook_open_full_visibility_changed():
	grab_focus()
