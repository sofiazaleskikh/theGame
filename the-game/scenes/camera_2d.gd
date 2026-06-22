extends Camera2D

var shake_intensity : float = 0.0
var shake_decay : float = 5.0

func _process(delta: float) -> void:
	if shake_intensity > 0:
		# Die Kamera wackelt leicht im Pixelbereich herum
		offset = Vector2(randf_range(-shake_intensity, shake_intensity), randf_range(-shake_intensity, shake_intensity))
		shake_intensity = move_toward(shake_intensity, 0.0, shake_decay * delta)
	else:
		offset = Vector2.ZERO

func apply_shake(intensity: float):
	shake_intensity = intensity
