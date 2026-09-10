class_name PlayerWindow2 extends TextureButton

var data: BattleActor = null:
	set(value):
		data = value
		visible = data != null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
