extends Node2D

@onready var enemy = get_tree().get_nodes_in_group("static_man")


var st_man = preload("res://enemies/static_man.tscn")
var spawn = false
var light_entered = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.max_st_man = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn:
		var newStatic = st_man.instantiate()
		newStatic.position = Vector2(randf_range(435, 1340), randf_range(69, 711))
		add_child(newStatic)
		
		if light_entered != true:
			newStatic.state_machine.travel("awake")
			newStatic.timer_awake.start()
		else:
			newStatic.state_machine.travel("asleep")
			newStatic.chasing = false
			newStatic.timer_awake.stop()
		
		Global.max_st_man += 1
		spawn = false
	
	spawn_new_one()


func spawn_new_one():
	if Global.max_st_man < 4:
		spawn = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		light_entered = true
		for e in get_tree().get_nodes_in_group("static_man"):
			if e == null or not is_instance_valid(e):
				continue
			
			e.state_machine.travel("asleep")
			e.chasing = false
			e.timer_awake.stop()
		##if body.has_method("st_man"):
			##body.awake_or_asleep()
#
#
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		light_entered = false
		for e in get_tree().get_nodes_in_group("static_man"):
			if e == null or not is_instance_valid(e):
				continue
			
			e.state_machine.travel("awake")
			e.timer_awake.start()
		##if body.has_method("st_man"):
			##body.awake_or_asleep()
