class_name EventQueue extends Node

enum Actions {
	ATTACK,
	BACK,
	RUN
}


var events: Array[Dictionary] = []

func add(action: Actions, actor: BattleActor, target: BattleActor) -> void:
	events.append({"action": action, "actor": actor, "target": target})
	#print("adding event: ", actor.actor_name, " ", Actions.keys()[action], " ", target.actor_name, ".")
