extends CanvasLayer

@export var current_health: int = 50
@export var max_health: int = 50
@export var attack: int = 25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	attacking()





func _on_christina_ui_visibility_changed() -> void:
	$christina_ui/Attack.grab_focus()


func _on_woodling_ui_visibility_changed() -> void:
	$woodling_ui/Cast.grab_focus()


func _on_christina_pressed() -> void:
	$select_character.visible = false
	$christina_stats.visible = true
	$christina_ui.visible = true


func _on_woodling_pressed() -> void:
	$select_character.visible = false
	$woodling_stats.visible = true
	$woodling_ui.visible = true






func _on_select_character_visibility_changed() -> void:
	if $select_character.visible:
		if $select_character/Christina.disabled == false:
			await get_tree().process_frame
			$select_character/Christina.grab_focus()
		else:
			await get_tree().process_frame
			$select_character/Woodling.grab_focus()


func set_health():
	$christina_stats/christina_health.value = current_health
	$christina_stats/christina_health.max_value = max_health
	$christina_stats/christina_health/Label.text = "%d/%d" % [current_health, max_health]





func _on_back_pressed() -> void:
	$select_character.visible = true
	$christina_stats.visible = false
	$christina_ui.visible = false


func _on_back_wood_pressed() -> void:
	$select_character.visible = true
	$woodling_stats.visible = false
	$woodling_ui.visible = false


func _on_attack_pressed() -> void:
	GlobalBattle.player_attacking = true


func attacking():
	if GlobalBattle.player_attacking == true:
		$christina_stats.visible = false
		$christina_ui.visible = false
		$strength.visible = true
		$strength.value += 1
	
	if $strength.value == 200:
		GlobalBattle.player_attacking = false
		$select_character.visible = true
		$strength.visible = false
		$strength.value = 0
	
