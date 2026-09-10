extends Node2D

const DialogueButtonPreload = preload("res://scenes/DIALOGUE/dialogue_button.tscn")

@onready var dialogue_label: RichTextLabel = $CanvasLayer/HBoxContainer/VBoxContainer/RichTextLabel
@onready var name_label: RichTextLabel = $CanvasLayer/HBoxContainer/VBoxContainer/name
@onready var SpeakerSprite: Sprite2D = $CanvasLayer/HBoxContainer/SpeakerParent/Sprite2D

var dialogue: Array[DE]
var current_dialogue_item: int = 0
var next_item: bool = true

var player_node: CharacterBody2D

func _ready() -> void:
	visible = false
	$CanvasLayer/HBoxContainer/VBoxContainer/button_container.visible = false
	
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i

func _process(_delta: float) -> void:
	if current_dialogue_item == dialogue.size():
		if !player_node:
			for i in get_tree().get_nodes_in_group("player"):
				player_node = i
			return
		Global.input_blocked = false
		queue_free()
		return
	
	if next_item:
		next_item = false
		var i = dialogue[current_dialogue_item]
		
		if i is DialogueFunction:
			if i.hide_dialogue_box:
				visible = false
			else:
				visible = true
			_function_resource(i)
		
		elif i is DialogueChoice:
			visible = true
			_choice_resource(i)
		
		elif i is DialogueText:
			visible = true
			_text_resource(i)
		
		else:
			printerr("You accidentally added a DE resource!")
			current_dialogue_item += 1
			next_item = true

func _function_resource(i: DialogueFunction) -> void:
	var target_node = get_node(i.target_path)
	if target_node.has_method(i.function_name):
		if i.function_arguments.size() == 0:
			target_node.call(i.function_name)
		else:
			target_node.callv(i.function_name, i.function_arguments)
	
	if i.wait_for_signal_to_continue:
		var signal_name = i.wait_for_signal_to_continue
		if target_node.has_signal(signal_name):
			var signal_state = { "done": false }
			var callable = func(_args): signal_state.done = true
			target_node.connect(signal_name, callable, CONNECT_ONE_SHOT)
			while not signal_state.done:
				await get_tree().process_frame
	
	current_dialogue_item += 1
	next_item = true

func _choice_resource(i : DialogueChoice) -> void:
	for child in $CanvasLayer/HBoxContainer/VBoxContainer/button_container.get_children():
		child.queue_free()
	await get_tree().process_frame
	dialogue_label.text = i.text
	dialogue_label.visible_characters = -1
	if i.speaker_image:
		$CanvasLayer/HBoxContainer/SpeakerParent.visible = true
		SpeakerSprite.texture = i.speaker_image
		SpeakerSprite.hframes = i.speaker_image_Hframes
		SpeakerSprite.frame = min(i.speaker_image_select_frame, i.speaker_image_Hframes - 1)
	else:
		$CanvasLayer/HBoxContainer/SpeakerParent.visible = false
	$CanvasLayer/HBoxContainer/VBoxContainer/button_container.visible = true

	for item in range(i.choice_text.size()):
		var DialogueButtonVar = DialogueButtonPreload.instantiate()
		DialogueButtonVar.text = i.choice_text[item]

		var function_resource : DialogueFunction = i.choice_function_call[item]
		var response_resource : DialogueText = i.choice_response[item]

		if function_resource:
			DialogueButtonVar.connect("pressed",
			Callable(get_node(function_resource.target_path), function_resource.function_name).bindv(function_resource.function_arguments),
			CONNECT_ONE_SHOT)
			if function_resource.hide_dialogue_box:
				DialogueButtonVar.connect("pressed", hide, CONNECT_ONE_SHOT)

			DialogueButtonVar.connect("pressed",
			_choice_button_pressed.bind(get_node(function_resource.target_path), function_resource.wait_for_signal_to_continue, response_resource),
			CONNECT_ONE_SHOT)
		else:
			DialogueButtonVar.connect("pressed", _choice_button_pressed.bind(null, "", response_resource), CONNECT_ONE_SHOT)

		$CanvasLayer/HBoxContainer/VBoxContainer/button_container.add_child(DialogueButtonVar)
	$CanvasLayer/HBoxContainer/VBoxContainer/button_container.get_child(0).grab_focus()

func _choice_button_pressed(target_node : Node, wait_for_signal_to_continue : String, response_resource : DialogueText):
	var DialogueButtonVar = DialogueButtonPreload.instantiate()
	if DialogueButtonVar.button_pressed:
		return
	DialogueButtonVar.button_pressed = true
	$CanvasLayer/HBoxContainer/VBoxContainer/button_container.visible = false
	for i in $CanvasLayer/HBoxContainer/VBoxContainer/button_container.get_children():
		i.queue_free()

	if wait_for_signal_to_continue:
		var signal_name = wait_for_signal_to_continue
		if target_node.has_signal(signal_name):
			var signal_state = { "done" : false }
			var callable = func(_args): signal_state.done = true
			target_node.connect(signal_name, callable, CONNECT_ONE_SHOT)
			while not signal_state.done:
				await get_tree().process_frame
		
	
	print("Before insert:")
	for i in dialogue:
		print(i.get_class(), ": ", i)

	insert_dialogue_response(response_resource)

	print("After insert:")
	for i in dialogue:
		print(i.get_class(), ": ", i)

	current_dialogue_item += 1
	next_item = true
	DialogueButtonVar.button_pressed = false

func insert_dialogue_response(response : DialogueText) -> void:
	if not response:
		return

	if not response.has_meta("is_response"):
		response.set_meta("is_response", true)
	
	var insert_pos := current_dialogue_item + 1

	if insert_pos < dialogue.size():
		var next_item = dialogue[insert_pos]
		if next_item == response:
			return
		elif next_item is DialogueText and next_item.has_meta("is_response") and next_item.get_meta("is_response") == true:
			dialogue.remove_at(insert_pos)

	dialogue.insert(insert_pos, response)


func _text_resource(i: DialogueText) -> void:
	name_label.text = i.speaker_name
	$AudioStreamPlayer.stream = i.text_sound
	$AudioStreamPlayer.volume_db = i.text_volume_db
	var camera: Camera2DPlus = get_viewport().get_camera_2d()
	if camera and i.camera_position != Vector2(999.999, 999.999):
		var camera_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		camera_tween.tween_property(camera, "global_position", i.camera_position, i.camera_transition_time)
	
	if !i.speaker_img:
		$CanvasLayer/HBoxContainer/SpeakerParent.visible = false
	else:
		$CanvasLayer/HBoxContainer/SpeakerParent.visible = true
		SpeakerSprite.texture = i.speaker_img
		SpeakerSprite.hframes = i.speaker_img_Hframes
		SpeakerSprite.frame = 0
	
	dialogue_label.visible_characters = 0
	dialogue_label.text = i.text
	var text_without_square_brackets: String = _text_without_square_brackets(i.text)
	var total_characters: int = text_without_square_brackets.length()
	var character_timer: float = 0.0
	while dialogue_label.visible_characters < total_characters:
		if Input.is_action_just_pressed("skip"):
			dialogue_label.visible_characters = total_characters
			break
		
		character_timer += get_process_delta_time()
		if character_timer >= (1.0 / i.text_speed) or text_without_square_brackets[dialogue_label.visible_characters] == " ":
			var character: String = text_without_square_brackets[dialogue_label.visible_characters]
			dialogue_label.visible_characters += 1
			if character != " ":
				$AudioStreamPlayer.pitch_scale = randf_range(i.text_volume_pitch_min, i.text_volume_pitch_max)
				$AudioStreamPlayer.play()
				if i.speaker_img_Hframes != 1:
					if SpeakerSprite.frame < i.speaker_img_Hframes - 1:
						SpeakerSprite.frame += 1
					else:
						SpeakerSprite.frame = 0
			character_timer = 0.0
		
		await get_tree().process_frame
	SpeakerSprite.frame = min(i.speaker_img_rest_frame, i.speaker_img_Hframes-1)
	
	while true:
		await get_tree().process_frame
		if dialogue_label.visible_characters == total_characters:
			if Input.is_action_just_pressed("accept"):
				current_dialogue_item += 1
				next_item = true

func _text_without_square_brackets(text: String) -> String:
	var result: String = ""
	var inside_bracket: bool = false
	
	for i in text:
		if i == "[":
			inside_bracket = true
			continue
		
		if i == "]":
			inside_bracket = false
			continue
		
		if !inside_bracket:
			result += i
	
	return result
