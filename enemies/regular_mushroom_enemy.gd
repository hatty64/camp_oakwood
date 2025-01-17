extends CharacterBody2D

var speed = 40
var chase_player = false
var player : CharacterBody2D
var alerted = false
var awake = false

func _ready() -> void:
	$detect_area/CollisionShape2D.scale.x = 1
	$detect_area/CollisionShape2D.scale.y = 1
	player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta):
	if chase_player == true:
		awake = true
		position += (player.position - position)/speed
		$AnimationPlayer.play("move_down")
		if player.position.x - position.x > 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		
	#else:
		#$AnimationPlayer.play("idle")
	
	if alerted == true:
		awake = false
		$AnimationPlayer.play("alert")
		await $AnimationPlayer.animation_finished
		alerted = false
		chase_player = true
	
	if awake == false:
		$AnimationPlayer.play("idle")
	
	move_and_slide()
	
	#if velocity.x > 0:
		#$AnimationPlayer.play("move_right")
	#else:
		#$AnimationPlayer.play("move_left")
	#
	#if velocity.y > 0:
		#$AnimationPlayer.play("move_down")
	#else:
		#$AnimationPlayer.play("move_up")


func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		awake = true
		alerted = true
		print("alerted")
		$detect_area/CollisionShape2D.disabled = true
		$detect_area/CollisionShape2D.scale.x = 0
		$detect_area/CollisionShape2D.scale.y = 0


#func _on_detect_area_body_exited(body: Node2D) -> void:
	#if body.has_method("player"):
		#alerted = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		get_tree().paused = true
		BattleTransition.chance_scene("res://combat/battle.tscn")
