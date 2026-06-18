extends Camera2D

# Vibración
var _trauma: float = 0.0
var _tiempo_vibracion: float = 0.0
const MAX_OFFSET := 8.0
const TRAUMA_DECAY := 2.5


func _process(delta: float) -> void:
	# Vibración (la cámara ya sigue al padre automáticamente en Godot)
	if _trauma > 0.0:
		_tiempo_vibracion += delta * 30.0
		var shake_x := MAX_OFFSET * _trauma * sin(_tiempo_vibracion * 2.3)
		var shake_y := MAX_OFFSET * _trauma * sin(_tiempo_vibracion * 1.7)
		offset = Vector2(shake_x, shake_y)
		_trauma = max(0.0, _trauma - TRAUMA_DECAY * delta)
	else:
		offset = Vector2.ZERO


func vibrar(intensidad: float = 0.6) -> void:
	_trauma = clamp(intensidad, 0.0, 1.0)
	_tiempo_vibracion = 0.0
