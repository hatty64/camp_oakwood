extends Control

const Actions: Dictionary = EventQueue.Actions

var sproutling = preload("res://combat/bullets/sproutling_attack.tscn").instantiate()
var mushroom_explode = preload("res://combat/bullets/mushroom_explode.tscn").instantiate()
var spawn_attacks = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	set_process(true)
	GlobalBattle.enemies_left = 1
	
	DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/combat.dialogue"), "Start")
	await DialogueManager.dialogue_ended
	$combat_ui/select_character.visible = true
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hit()
	
	enemy_turn()
	if GlobalBattle.enemies_left == 0:
		set_process(false)
		$combat_ui/christina_stats.visible = false
		$combat_ui/christina_ui.visible = false
		$combat_ui/select_character.visible = false
		DialogueManager.show_dialogue_regular_balloon(load("res://dialogue/combat.dialogue"), "Start_win")
		await DialogueManager.dialogue_ended
		get_tree().quit()
	
	#if GlobalBattle.enemies_turns == false:
		#$Sprite2D.position.x = 982
		#$Sprite2D.position.y = 369
	#else:
		#$Sprite2D.position.x = 236
		#$Sprite2D.position.y = -578



func hit():
	if GlobalBattle.player_attacking == true:
		if Input.is_action_just_pressed("accept"):
			$Sprite2D.health -= $combat_ui.attack
			GlobalBattle.player_attacking = false
			GlobalBattle.enemy_damage = true
			$combat_ui/strength.visible = false
			$combat_ui/strength.value = 0
			await $Sprite2D/AnimationPlayer.animation_finished
			$combat_ui/select_character.visible = true
			GlobalBattle.christina_finished = true
			print_debug($Sprite2D.health)

func enemy_turn():
	if GlobalBattle.enemies_turns == true:
		if spawn_attacks == true:
			add_child(sproutling)
			add_child(mushroom_explode)
			spawn_attacks = false
		$combat_ui/ColorRect.visible = false
		$enemy_turn/CanvasLayer.visible = true
		$enemy_turn.visible = true
		#$combat_ui.visible = false
		$combat_ui/christina_stats.visible = true
		$combat_ui/christina_ui.visible = false
		$combat_ui/woodling_ui.visible = false
		$combat_ui/woodling_stats.visible = false
		$combat_ui/select_character.visible = false
		Global.input_blocked = false
	else:
		$enemy_turn/CanvasLayer.visible = false
		$enemy_turn.visible = false
		#$combat_ui.visible = true
		Global.input_blocked = true
	
	#testing only
	if Input.is_action_just_pressed("pause"):
		GlobalBattle.enemies_turns = true
