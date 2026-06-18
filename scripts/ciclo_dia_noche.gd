extends CanvasLayer

# Cubre toda la pantalla con un ColorRect que aplica el shader día/noche
# El ciclo completo es de 365 días de juego = 1 año

const DIAS_POR_CICLO := 365.0
const DURACION_TRANSICION := 2.0  # segundos de transición suave

var _hora_actual: float = 0.5  # 0=medianoche 0.5=mediodía 1=medianoche
var _hora_objetivo: float = 0.5
var _material: ShaderMaterial

@onready var overlay: ColorRect = $Overlay


func _ready() -> void:
	_material = ShaderMaterial.new()
	_material.shader = load("res://shaders/dia_noche.gdshader")
	overlay.material = _material
	_actualizar_hora_desde_dia()
	GameState.dia_avanzado.connect(_on_dia_avanzado)


func _process(delta: float) -> void:
	# Interpolar suavemente hacia la hora objetivo
	_hora_actual = move_toward(_hora_actual, _hora_objetivo, delta / DURACION_TRANSICION)
	_material.set_shader_parameter("hora_dia", _hora_actual)


func _on_dia_avanzado(_dia: int) -> void:
	_actualizar_hora_desde_dia()


func _actualizar_hora_desde_dia() -> void:
	var dia := GameState.dia_actual
	# Cada 7 días = un ciclo completo día/noche simplificado
	# Días 1-3: día, días 4-5: tarde/noche, días 6-7: madrugada
	var fase := fmod(float(dia - 1), 7.0) / 7.0
	_hora_objetivo = fase
