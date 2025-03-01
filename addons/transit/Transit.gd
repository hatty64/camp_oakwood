extends Control

signal scene_changed

const DEFAULT_DURATION := 0.05
const DEFAULT_DELAY := 0.0

@onready var _animator := $AnimationPlayer
@onready var _curtain := $CanvasLayer/ColorRect

func set_color(color: Color):
	color.a = _curtain.color.a
	_curtain.color = color

func change_scene_to_file(path: String, duration: float = DEFAULT_DURATION, delay: float = DEFAULT_DELAY):
	if duration <= 0.0:
		push_error("TRANSIT ERROR: change_scene duration must be > 0. Defaulting to %s" % DEFAULT_DURATION)
		duration = DEFAULT_DURATION

	if delay < 0.0:
		push_error("TRANSIT ERROR: change_scene delay must be >= 0. Defaulting to %s" % DEFAULT_DELAY)
		delay = DEFAULT_DELAY

	# disable mouse interaction while fading out
	_curtain.mouse_filter = MOUSE_FILTER_STOP

	if delay > 0:
		await get_tree().create_timer(delay).timeout

	_animator.speed_scale = 0.5 / duration
	_animator.play("fade")
	GlobalDays.transition_start()
	await _animator.animation_finished

	var err := get_tree().change_scene_to_file(path)
	if err:
		push_error("TRANSIT ERROR: Failed to change scene to %s: %s" % [path, err])

	# re-enable mouse interaction before fading back in
	_curtain.mouse_filter = MOUSE_FILTER_IGNORE

	_animator.play_backwards("fade")
	await _animator.animation_finished
	GlobalDays.transition_end()

	emit_signal("scene_changed")
