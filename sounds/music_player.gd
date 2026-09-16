extends AudioStreamPlayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const scene_music = preload("res://music/a_new_day_loop.mp3")
const a_new_day = preload("res://music/a_new_day.mp3")
const night_scene_ver = preload("res://music/night_cutscene_ver.mp3")
const dining = preload("res://music/camp_oakwood_dining.mp3")
const panic = preload("res://music/panic.mp3")

func play_sound(music: AudioStream, volume = -10.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	

func pitchdown_music():
	animation_player.play("pitchdown_music")
	await animation_player.animation_finished
	stop()
	animation_player.play("RESET")

func fadeout_music():
	animation_player.play("fadeout_music")
	await animation_player.animation_finished
	stop()
	animation_player.play("RESET")

func play_music_level():
	play_sound(scene_music)

func play_a_new_day():
	play_sound(a_new_day)

func play_night_cutscene():
	play_sound(night_scene_ver)

func play_dining():
	play_sound(dining)

func play_panic():
	play_sound(panic)
