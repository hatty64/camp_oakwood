extends Control


var points = 0



func _on_button_pressed() -> void:
	$HBoxContainer/Label.text = str(round(randf()*9))
	$HBoxContainer/Label2.text = str(round(randf()*9))
	$HBoxContainer/Label3.text = str(round(randf()*9))
	
	if $HBoxContainer/Label.text == $HBoxContainer/Label2.text:
		$Label2.text += str(int(10))
