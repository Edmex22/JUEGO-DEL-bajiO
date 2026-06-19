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
	if _jugador:
		var pos := GameState.posicion_jugador_exterior
		_jugador.position = pos if pos != Vector2.ZERO else Vector2(ancho / 2.0, alto - 60.0)

	if _zona_salida and not _zona_salida.get_script():
		_zona_salida.body_entered.connect(_on_salida_entered)
		_zona_salida.body_exited.connect(_on_salida_exited)

	_dibujar_fondo()
	_agregar_paredes()

	if has_node("/root/Transicion"):
		get_node("/root/Transicion").fade_in()


func _agregar_paredes() -> void:
	# Pared norte (incluye zona de muebles contra la pared)
	_colision(Vector2(0, 0), Vector2(ancho, 92))
	# Pared oeste
	_colision(Vector2(0, 0), Vector2(22, alto))
	# Pared este
	_colision(Vector2(ancho - 22, 0), Vector2(22, alto))
	# Borde sur (deja paso en el centro para la salida)
	_colision(Vector2(0, alto - 20), Vector2(260, 20))
	_colision(Vector2(380, alto - 20), Vector2(260, 20))


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


# ── Helpers de dibujo y colisión para subclases ──────────────────────────────

func _colision(pos: Vector2, tam: Vector2) -> void:
	var sb := StaticBody2D.new()
	sb.position = pos
	var cs := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = tam
	cs.position = tam / 2.0
	cs.shape = shape
	sb.add_child(cs)
	add_child(sb)


func _sombra(pos: Vector2, tam: Vector2, desplazamiento: Vector2 = Vector2(4, 6)) -> void:
	_rect(pos + desplazamiento, tam, Color(0, 0, 0, 0.22))


func _rect(pos: Vector2, size: Vector2, color: Color) -> void:
	var r := ColorRect.new()
	r.position = pos
	r.size = size
	r.color = color
	_fondo.add_child(r)


func _label(texto: String, pos: Vector2, size: int = 10, color: Color = Color("#5A3A10"), ancho_max: int = 0) -> void:
	var l := Label.new()
	l.text = texto
	l.position = pos
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	if ancho_max > 0:
		l.size = Vector2(ancho_max, 200)
		l.clip_text = false
		l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
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
	# Fondo para la etiqueta
	_rect(pos + Vector2(-20, 74), Vector2(96, 18), Color(0, 0, 0, 0.55))
	_label(etiqueta, pos + Vector2(-18, 76), 8, Color("#FFD080"), 92)


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


func _lampara(pos: Vector2) -> void:
	# Cuerpo de la lámpara colgante
	_rect(pos + Vector2(10, 0), Vector2(4, 14), Color("#888888"))
	_rect(pos, Vector2(24, 12), Color("#DDCC88"))
	_rect(pos + Vector2(2, 2), Vector2(20, 8), Color("#FFEE99"))
	# Halo de luz en el piso (debajo de la lámpara)
	var halo_pos := Vector2(pos.x - 20, pos.y + 60)
	_rect(halo_pos, Vector2(64, 24), Color(1.0, 0.97, 0.8, 0.15))


func _alfombra(pos: Vector2, tam: Vector2, color: Color) -> void:
	_rect(pos, tam, color.darkened(0.3))
	_rect(pos + Vector2(4, 4), tam - Vector2(8, 8), color)
	_rect(pos + Vector2(8, 8), tam - Vector2(16, 16), color.lightened(0.1))
	# Borde decorativo
	_rect(pos + Vector2(4, 4), Vector2(tam.x - 8, 3), color.darkened(0.2))
	_rect(pos + Vector2(4, tam.y - 7), Vector2(tam.x - 8, 3), color.darkened(0.2))


func _sofa(pos: Vector2, color: Color = Color("#8B5E3C")) -> void:
	# Base
	_rect(pos, Vector2(96, 40), color.darkened(0.3))
	# Asiento
	_rect(pos + Vector2(4, 4), Vector2(88, 28), color)
	# Respaldo
	_rect(pos + Vector2(0, -22), Vector2(96, 24), color.darkened(0.1))
	# Brazos
	_rect(pos + Vector2(0, -22), Vector2(12, 62), color.darkened(0.2))
	_rect(pos + Vector2(84, -22), Vector2(12, 62), color.darkened(0.2))
	# Cojines
	_rect(pos + Vector2(14, -18), Vector2(28, 18), color.lightened(0.1))
	_rect(pos + Vector2(54, -18), Vector2(28, 18), color.lightened(0.1))


func _estante_libros(pos: Vector2, filas: int = 3) -> void:
	_rect(pos, Vector2(80, filas * 36 + 8), Color("#5C3D1E"))
	_rect(pos + Vector2(0, filas * 36 + 4), Vector2(80, 4), Color("#3A2010"))
	var colores := [Color("#1A3A6A"), Color("#6A1A1A"), Color("#1A5A1A"),
					Color("#5A4A1A"), Color("#3A1A5A"), Color("#6A4A1A")]
	for ry in range(filas):
		_rect(pos + Vector2(2, 4 + ry * 36), Vector2(76, 4), Color("#3A2010"))
		var x := 4
		var ci := 0
		while x < 74:
			var w := 6 + (ci % 3) * 3
			_rect(pos + Vector2(x, 8 + ry * 36), Vector2(w, 26), colores[(ry * 4 + ci) % colores.size()])
			x += w + 2
			ci += 1


func _cuadro_enmarcado(pos: Vector2, tam: Vector2, color_marco: Color, color_interior: Color, texto: String = "") -> void:
	if tam.x == 0 and tam.y == 0:
		return
	# Sombra
	_rect(pos + Vector2(3, 3), tam + Vector2(4, 4), Color(0, 0, 0, 0.3))
	# Marco
	_rect(pos, tam + Vector2(4, 4), color_marco)
	_rect(pos + Vector2(4, 4), tam - Vector2(4, 4), color_interior)
	if texto != "":
		_label(texto, pos + Vector2(6, 6), 8, color_marco.lightened(0.5), int(tam.x - 8))


func _planta_grande(pos: Vector2) -> void:
	# Maceta grande
	_rect(pos + Vector2(6, 36), Vector2(28, 30), Color("#964B00"))
	_rect(pos + Vector2(4, 32), Vector2(32, 8), Color("#7A3A00"))
	# Tallo
	_rect(pos + Vector2(18, 12), Vector2(4, 26), Color("#2D6A20"))
	# Hojas
	_rect(pos, Vector2(40, 20), Color("#2ECC71"))
	_rect(pos + Vector2(4, -14), Vector2(32, 18), Color("#27AE60"))
	_rect(pos + Vector2(-8, 8), Vector2(20, 14), Color("#2ECC71"))
	_rect(pos + Vector2(28, 8), Vector2(20, 14), Color("#2ECC71"))
	_rect(pos + Vector2(8, -24), Vector2(24, 14), Color("#58D68D"))


func _columna(pos: Vector2, alto_col: int = 120) -> void:
	_rect(pos, Vector2(20, alto_col), Color("#D4C8A0"))
	_rect(pos + Vector2(2, 0), Vector2(16, alto_col), Color("#E8DDB8"))
	_rect(pos + Vector2(0, 0), Vector2(20, 10), Color("#C0B490"))
	_rect(pos + Vector2(0, alto_col - 10), Vector2(20, 10), Color("#C0B490"))


func _cama_hospital(pos: Vector2) -> void:
	# Marco metálico
	_rect(pos, Vector2(80, 44), Color("#A0A0A0"))
	_rect(pos + Vector2(2, 2), Vector2(76, 40), Color("#C0C0C0"))
	# Colchón
	_rect(pos + Vector2(4, 4), Vector2(72, 32), Color("#FFFFFF"))
	# Sábana
	_rect(pos + Vector2(4, 4), Vector2(72, 22), Color("#E8F4FD"))
	# Almohada
	_rect(pos + Vector2(6, 6), Vector2(22, 16), Color("#F0F0F0"))
	# Cabecera
	_rect(pos + Vector2(0, -10), Vector2(80, 12), Color("#888888"))
	# Ruedas
	_rect(pos + Vector2(4,  40), Vector2(8, 6), Color("#666666"))
	_rect(pos + Vector2(68, 40), Vector2(8, 6), Color("#666666"))


func _mostrador(pos: Vector2, ancho_m: int, color: Color = Color("#8B6914")) -> void:
	# Sombra
	_rect(pos + Vector2(2, 4), Vector2(ancho_m, 56), Color(0, 0, 0, 0.2))
	# Lateral oscuro (profundidad)
	_rect(pos + Vector2(0, 48), Vector2(ancho_m, 8), color.darkened(0.4))
	# Frente del mostrador
	_rect(pos, Vector2(ancho_m, 48), color.darkened(0.15))
	# Borde superior
	_rect(pos + Vector2(0, -10), Vector2(ancho_m, 12), color.lightened(0.1))
	# Línea decorativa
	_rect(pos + Vector2(0, -2), Vector2(ancho_m, 3), color.lightened(0.3))
