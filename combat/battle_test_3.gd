extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/combat.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	$combat_ui/select_character.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hit()


func hit():
	if GlobalBattle.player_attacking == true:
		if Input.is_action_just_pressed("accept"):
			$Sprite2D.health -= $combat_ui.attack
			GlobalBattle.player_attacking = false
			print_debug($Sprite2D.health)
