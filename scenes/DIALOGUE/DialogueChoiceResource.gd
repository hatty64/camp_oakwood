extends DE
class_name DialogueChoice

@export var speaker_name : String
@export var speaker_image : Texture
@export var speaker_image_Hframes : int = 1
@export var speaker_image_select_frame : int = 0

@export_multiline var text : String

@export var choice_text : Array[String]
@export var choice_response : Array[DialogueText]
@export var choice_function_call : Array[DialogueFunction]
