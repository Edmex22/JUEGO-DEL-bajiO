extends Node2D

## Clase base para todas las escenas interiores.
## Dibuja el fondo, maneja la zona de salida y el fade in.

@export var escena_destino: String = "res://main.tscn"
@export var posicion_llegada: Vector2 = Vector2(0, 288)

# Dimensiones del interior
@export var ancho: int = 640
@export var alto: int  = 480

var _jugador_en_salida := false

@onready var _zona_salida: Area2D  = get_node_or_null("ZonaSalida")
@onready var _hint_salida: Label   = get_node_or_null("UI/LabelSalida")
@onready var _fondo: Node2D        = get_node_or_null("Fondo")
@onready var _jugador: CharacterBody2D = get_node_or_null("Player")


func _ready() -> void:
	# Posición del jugador al entrar
	if _jugador:
		var pos := GameState.posicion_jugador_exterior
		_jugador.position = pos if pos != Vector2.ZERO else Vector2(ancho / 2.0, alto - 60.0)

	# Solo conecta si ZonaSalida no tiene su propio script (puerta.gd lo maneja solo)
	if _zona_salida and not _zona_salida.get_script():
		_zona_salida.body_entered.connect(_on_salida_entered)
		_zona_salida.body_exited.connect(_on_salida_exited)

	_dibujar_fondo()

	if has_node("/root/Transicion"):
		get_node("/root/Transicion").fade_in()


func _dibujar_fondo() -> void:
	# Subclases sobreescriben esto para personalizar el interior
	pass


func _on_salida_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_en_salida = true
		if _hint_salida: _hint_salida.visible = true


func _on_salida_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_en_salida = false
		if _hint_salida: _hint_salida.visible = false


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_E and _jugador_en_salida:
			GameState.posicion_jugador_exterior = posicion_llegada
			if has_node("/root/Transicion"):
				get_node("/root/Transicion").ir_a_escena(escena_destino)
			else:
				get_tree().change_scene_to_file(escena_destino)


# ── Helpers de dibujo para subclases ─────────────────────────────────────────

func _rect(pos: Vector2, size: Vector2, color: Color) -> void:
	var r := ColorRect.new()
	r.position = pos
	r.size = size
	r.color = color
	_fondo.add_child(r)


func _label(texto: String, pos: Vector2, size: int = 10, color: Color = Color("#5A3A10")) -> void:
	var l := Label.new()
	l.text = texto
	l.position = pos
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	_fondo.add_child(l)


func _ventana(pos: Vector2) -> void:
	_rect(pos, Vector2(48, 36), Color("#4A7FA5"))
	_rect(pos + Vector2(2,  2), Vector2(20, 32), Color("#7AB8D8"))
	_rect(pos + Vector2(26, 2), Vector2(20, 32), Color("#7AB8D8"))
	_rect(pos + Vector2(22, 0), Vector2(4,  36), Color("#D4C8A0"))


func _puerta_interior(pos: Vector2, etiqueta: String) -> void:
	_rect(pos, Vector2(56, 72), Color("#6B3A2A"))
	_rect(pos + Vector2(4,  4), Vector2(22, 64), Color("#7A4535"))
	_rect(pos + Vector2(30, 4), Vector2(22, 64), Color("#7A4535"))
	_label(etiqueta, pos + Vector2(2, 76), 8, Color("#FFD080"))


func _escritorio(pos: Vector2) -> void:
	_rect(pos, Vector2(72, 44), Color("#8B6914"))
	_rect(pos + Vector2(0, -10), Vector2(72, 12), Color("#A07820"))
	# Papel encima
	_rect(pos + Vector2(8, 6), Vector2(30, 22), Color("#FFFDF0"))
	_rect(pos + Vector2(44, 8), Vector2(20, 18), Color("#E8F4FD"))


func _silla(pos: Vector2) -> void:
	_rect(pos, Vector2(32, 32), Color("#8B7355"))
	_rect(pos + Vector2(3, 3), Vector2(26, 26), Color("#A08060"))
	_rect(pos + Vector2(0, -18), Vector2(32, 20), Color("#8B7355"))


func _maceta(pos: Vector2) -> void:
	_rect(pos, Vector2(18, 24), Color("#964B00"))
	_rect(pos + Vector2(2, -10), Vector2(14, 12), Color("#2D5A27"))
	_rect(pos + Vector2(5, -22), Vector2(8, 14), Color("#3A7A30"))


func _bandera(pos: Vector2) -> void:
	_rect(pos, Vector2(3, 48), Color("#4A4A4A"))
	_rect(pos + Vector2(3, 0),  Vector2(13, 30), Color("#006847"))
	_rect(pos + Vector2(16, 0), Vector2(13, 30), Color("#FFFFFF"))
	_rect(pos + Vector2(29, 0), Vector2(13, 30), Color("#CE1126"))
