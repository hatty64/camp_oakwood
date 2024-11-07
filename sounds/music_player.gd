extends AudioStreamPlayer

const scene_music = preload("res://music/dining_demo.mp3")
const a_new_day = preload("res://music/a_new_day.mp3")

func play_sound(music: AudioStream, volume = -10.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	

func play_music_level():
	play_sound(scene_music)

func play_a_new_day():
	play_sound(a_new_day)
