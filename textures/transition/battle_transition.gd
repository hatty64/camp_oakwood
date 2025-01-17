extends CanvasLayer


func chance_scene(target: String) -> void:
	Global.input_blocked = true
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Global.input_blocked = false

func change_packed_scene(target: PackedScene) -> void:
	Global.input_blocked = true
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	Global.input_blocked = false
