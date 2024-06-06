extends AudioStreamPlayer

const scene_music = preload("res://scenes/forest-wind-and-birds-6881.mp3")

func play_sound(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	

func play_music_level():
	play_sound(scene_music)
