class_name PlayerWindow extends HBoxContainer

#@onready var party: Array = PartyData.party

#var player_data: BattleActor = null:
	#set(value):
		#player_data = value
		#visible = player_data != null 

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#for i in range(get_child_count()):
		#if i < party.size():
			#get_child(i).data = party[i]
		#else:
			#get_child(i).data = null
		#var player: BattleActor = party[i]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
