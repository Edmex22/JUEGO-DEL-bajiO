extends CanvasLayer

signal dialogo_cerrado

const VELOCIDAD_TEXTO := 0.035  # segundos por caracter

@onready var panel: Panel         = $PanelDialogo
@onready var nombre_label: Label  = $PanelDialogo/VBox/NombreLabel
@onready var texto_label: Label   = $PanelDialogo/VBox/TextoLabel
@onready var continuar_label: Label = $PanelDialogo/VBox/ContinuarLabel

var _lineas: Array[String] = []
var _linea_actual: int = 0
var _escribiendo: bool = false
var _texto_completo: String = ""
var _timer: float = 0.0
var _char_idx: int = 0


func _ready() -> void:
	panel.visible = false
	continuar_label.text = "▼  E = continuar   Esc = cerrar"
	# Debe procesar input aunque el árbol esté pausado
	process_mode = Node.PROCESS_MODE_ALWAYS


func _process(delta: float) -> void:
	if not _escribiendo:
		return
	_timer += delta
	if _timer >= VELOCIDAD_TEXTO:
		_timer = 0.0
		_char_idx += 1
		texto_label.text = _texto_completo.substr(0, _char_idx)
		if _char_idx >= _texto_completo.length():
			_escribiendo = false
			continuar_label.visible = true


func mostrar(nombre: String, lineas: Array) -> void:
	_lineas.clear()
	for l in lineas:
		_lineas.append(str(l))
	_linea_actual = 0
	nombre_label.text = nombre
	nombre_label.visible = nombre != ""
	panel.visible = true
	get_tree().paused = true
	_mostrar_linea()


func _mostrar_linea() -> void:
	if _linea_actual >= _lineas.size():
		_cerrar()
		return
	_texto_completo = _lineas[_linea_actual]
	_char_idx = 0
	_escribiendo = true
	continuar_label.visible = false
	texto_label.text = ""


func _cerrar() -> void:
	panel.visible = false
	get_tree().paused = false
	emit_signal("dialogo_cerrado")


func _unhandled_input(event: InputEvent) -> void:
	if not panel.visible:
		return
	if event.is_action_pressed("ui_cancel"):
		# Escape: cerrar diálogo inmediatamente
		_cerrar()
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("interactuar"):
		if _escribiendo:
			# Mostrar todo el texto inmediatamente
			_escribiendo = false
			texto_label.text = _texto_completo
			_char_idx = _texto_completo.length()
			continuar_label.visible = true
		else:
			_linea_actual += 1
			_mostrar_linea()
		get_viewport().set_input_as_handled()
