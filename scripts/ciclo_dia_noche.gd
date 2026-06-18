extends CanvasLayer

const DURACION_TRANSICION := 2.0

# Colores del overlay (fondo semitransparente que tinta la escena)
const COLOR_DIA       := Color(0.0, 0.0, 0.0, 0.0)       # transparente
const COLOR_ATARDECER := Color(0.6, 0.2, 0.0, 0.35)       # naranja oscuro
const COLOR_NOCHE     := Color(0.05, 0.08, 0.25, 0.72)    # azul noche
const COLOR_AMANECER  := Color(0.5, 0.15, 0.0, 0.25)      # naranja suave

var _color_actual: Color = COLOR_DIA
var _color_objetivo: Color = COLOR_DIA

@onready var overlay: ColorRect = $Overlay


func _ready() -> void:
	GameState.dia_avanzado.connect(_on_dia_avanzado)
	_actualizar_objetivo()


func _process(delta: float) -> void:
	_color_actual = _color_actual.lerp(_color_objetivo, delta / DURACION_TRANSICION)
	overlay.color = _color_actual


func _on_dia_avanzado(_dia: int) -> void:
	_actualizar_objetivo()


func _actualizar_objetivo() -> void:
	# Ciclo de 7 días: 1-3 día, 4 atardecer, 5-6 noche, 7 amanecer
	var fase := (GameState.dia_actual - 1) % 7
	match fase:
		0, 1, 2: _color_objetivo = COLOR_DIA
		3:        _color_objetivo = COLOR_ATARDECER
		4, 5:     _color_objetivo = COLOR_NOCHE
		6:        _color_objetivo = COLOR_AMANECER
