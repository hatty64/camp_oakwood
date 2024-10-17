extends AudioStreamPlayer

const bird_sound = preload("res://scenes/forest-wind-and-birds-6881.mp3")
const rain = preload("res://sounds/rain-sound-188158.mp3")

func play_sound(music: AudioStream, volume = -10.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	

func play_bird_sound():
	play_sound(bird_sound)

func play_rain():
	play_sound(rain)
