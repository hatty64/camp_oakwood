extends Node

var ep_one_day_one = false
var ep_one_day_two = false
var ep_one_day_three = false

var finish_day_zero = false




var woke_up = false

var ep1_day1_cutscene1 = false

func play_cutscene():
	Global.input_blocked = true

func end_cutscene():
	Global.input_blocked = false

func transition_start():
	Global.input_blocked = true

func transition_end():
	Global.input_blocked = false

func start_dialogue():
	Global.input_blocked = true

func end_dialogue():
	Global.input_blocked = false
