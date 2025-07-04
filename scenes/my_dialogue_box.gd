extends CanvasLayer

@onready var balloon: NinePatchRect = %Balloon
@onready var character_label: RichTextLabel = %CharacterLabel
@onready var portrait: TextureRect = $Balloon/Dialogue/HBoxContainer/Portrait
@onready var dialogue_label: DialogueLabel = %DialogueLabel
@onready var responses_menu: DialogueResponsesMenu = %ResponsesMenu
#@onready var night_talk: AudioStreamPlayer2D = $night_talk
@onready var text_sound = $text_sound
## The dialogue resource
var resource: DialogueResource

## Temporary game states
var temporary_game_states: Array = []

## See if we are waiting for the player
var is_waiting_for_input: bool = false

## See if we are running a long mutation and should hide the balloon
var will_hide_balloon: bool = false

## The current line
var dialogue_line: DialogueLine:
	set(next_dialogue_line):
		is_waiting_for_input = false

		# The dialogue has finished so close the balloon
		if not next_dialogue_line:
			queue_free()
			return

		dialogue_line = next_dialogue_line

		character_label.visible = not dialogue_line.character.is_empty()
		character_label.text = tr(dialogue_line.character, "dialogue")

		dialogue_label.hide()
		dialogue_label.dialogue_line = dialogue_line
		var chr = dialogue_line.get_tag_value("chr")
		var text_sound_path: String = "res://character_sounds/%s.wav" % [chr.to_lower()]
		if ResourceLoader.exists(text_sound_path):
			text_sound.stream = load(text_sound_path)
		else:
			text_sound.stream = null

		var mood = dialogue_line.get_tag_value("mood")
		var portrait_emotion_path: String = "res://portraits/%s/%s.png" % [chr.to_lower(), mood]
		if ResourceLoader.exists(portrait_emotion_path):
			portrait.texture = load(portrait_emotion_path)
			portrait.custom_minimum_size.x = 300
		else:
			portrait.texture = null
			portrait.custom_minimum_size.x = 0


		responses_menu.hide()
		responses_menu.set_responses(dialogue_line.responses)

		# Show our balloon
		balloon.show()
		will_hide_balloon = false


		dialogue_label.show()
		if not dialogue_line.text.is_empty():
			dialogue_label.type_out()
			await dialogue_label.finished_typing

		# Wait for input
		if dialogue_line.responses.size() > 0:
			balloon.focus_mode = Control.FOCUS_NONE
			responses_menu.show()
		elif dialogue_line.time != "":
			var time = dialogue_line.text.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
			await get_tree().create_timer(time).timeout
			next(dialogue_line.next_id)
		else:
			is_waiting_for_input = true
			balloon.focus_mode = Control.FOCUS_ALL
			balloon.grab_focus()
	get:
		return dialogue_line




func _ready() -> void:
	balloon.hide()
	Engine.get_singleton("DialogueManager").mutated.connect(_on_mutated)


func _unhandled_input(_event: InputEvent) -> void:
	# Only the balloon is allowed to handle input while it's showing
	get_viewport().set_input_as_handled()


## Start some dialogue
func start(dialogue_resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	temporary_game_states =  [self] + extra_game_states
	is_waiting_for_input = false
	resource = dialogue_resource
	self.dialogue_line = await resource.get_next_dialogue_line(title, temporary_game_states)


## Go to the next line
func next(next_id: String) -> void:
	self.dialogue_line = await resource.get_next_dialogue_line(next_id, temporary_game_states)


### Signals


func _on_mutated(_mutation: Dictionary) -> void:
	is_waiting_for_input = false
	will_hide_balloon = true
	$TimerDialogue.timeout.connect(func():
		if will_hide_balloon:
			will_hide_balloon = false
			balloon.hide()
	)



#func _process(delta: float) -> void:
	#skip_dialogue()




func _on_balloon_gui_input(event: InputEvent) -> void:
# If the user clicks on the balloon while it's typing then skip typing
	if dialogue_label.is_typing and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		get_viewport().set_input_as_handled()
		dialogue_label.skip_typing()
		return

	if not is_waiting_for_input: return
	if dialogue_line.responses.size() > 0: return

	# When there are no response options the balloon itself is the clickable thing
	get_viewport().set_input_as_handled()

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1 and get_tree().paused == true:
		next(dialogue_line.next_id)
		print("WEF`1")
	elif event.is_action_pressed("accept") and get_viewport().gui_get_focus_owner() == balloon and get_tree().paused != true:
		next(dialogue_line.next_id) 
		


func _on_response_menu_response_selected(response: DialogueResponse) -> void:
	next(response.next_id)

func _on_dialogue_label_spoke(letter, _letter_index, _speed):
	if not letter in [".", " "]:
		#text_sound.pitch_scale = randf_range(0.9, 1.1)
		text_sound.play()

#func skip_dialogue():
	#if Input.is_action_just_pressed("skip_all"):
		#queue_free()
