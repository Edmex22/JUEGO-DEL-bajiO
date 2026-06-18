extends Camera2D

const ZOOM_MIN    := Vector2(0.4, 0.4)   # alejado: ves toda la ciudad
const ZOOM_MAX    := Vector2(3.0, 3.0)   # cerca: detalle de pixel art
const ZOOM_PASO   := 0.12
const ZOOM_SUAVE  := 8.0                 # velocidad de interpolación del zoom

var _zoom_objetivo: Vector2 = Vector2(1.5, 1.5)

# Vibración
var _trauma: float = 0.0
var _tiempo_vibracion: float = 0.0
const MAX_OFFSET   := 8.0
const TRAUMA_DECAY := 2.5


func _ready() -> void:
	zoom = _zoom_objetivo


func _process(delta: float) -> void:
	# Zoom suave
	zoom = zoom.lerp(_zoom_objetivo, ZOOM_SUAVE * delta)

	# Vibración
	if _trauma > 0.0:
		_tiempo_vibracion += delta * 30.0
		var shake_x := MAX_OFFSET * _trauma * sin(_tiempo_vibracion * 2.3)
		var shake_y := MAX_OFFSET * _trauma * sin(_tiempo_vibracion * 1.7)
		offset = Vector2(shake_x, shake_y)
		_trauma = max(0.0, _trauma - TRAUMA_DECAY * delta)
	else:
		offset = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				_zoom_objetivo = (_zoom_objetivo + Vector2(ZOOM_PASO, ZOOM_PASO)).clamp(ZOOM_MIN, ZOOM_MAX)
				get_viewport().set_input_as_handled()
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				_zoom_objetivo = (_zoom_objetivo - Vector2(ZOOM_PASO, ZOOM_PASO)).clamp(ZOOM_MIN, ZOOM_MAX)
				get_viewport().set_input_as_handled()


func vibrar(intensidad: float = 0.6) -> void:
	_trauma = clamp(intensidad, 0.0, 1.0)
	_tiempo_vibracion = 0.0
