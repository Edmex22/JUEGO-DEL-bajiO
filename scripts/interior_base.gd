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
	_aplicar_ambiente()
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
	# Sombra suave en dos capas (penumbra + núcleo) con dirección de luz coherente
	_rect(pos + desplazamiento + Vector2(3, 3), tam + Vector2(4, 4), Color(0, 0, 0, 0.08))
	_rect(pos + desplazamiento + Vector2(1, 1), tam + Vector2(2, 2), Color(0, 0, 0, 0.12))
	_rect(pos + desplazamiento, tam, Color(0, 0, 0, 0.20))


func _bisel(pos: Vector2, tam: Vector2, color: Color, fuerza: float = 0.20) -> void:
	# Volumen 3/4: luz arriba-izquierda, sombra abajo-derecha (luz desde el norte)
	_rect(pos, tam, color)
	_rect(pos, Vector2(tam.x, 2), color.lightened(fuerza))
	_rect(pos, Vector2(2, tam.y), color.lightened(fuerza * 0.6))
	_rect(pos + Vector2(0, tam.y - 2), Vector2(tam.x, 2), color.darkened(fuerza))
	_rect(pos + Vector2(tam.x - 2, 0), Vector2(2, tam.y), color.darkened(fuerza * 0.6))


func _aplicar_ambiente() -> void:
	# Capa de iluminación ambiental aplicada SOBRE el fondo (queda bajo el jugador).
	# 1) Tinte cálido global para cohesión cromática (golden-hour muy sutil)
	_rect(Vector2.ZERO, Vector2(ancho, alto), Color(1.0, 0.86, 0.55, 0.05))
	# 2) Oclusión ambiental en la unión muro norte / piso
	_rect(Vector2(0, 72), Vector2(ancho, 10), Color(0, 0, 0, 0.10))
	_rect(Vector2(0, 72), Vector2(ancho, 5),  Color(0, 0, 0, 0.08))
	# 3) Viñeta suave: oscurece ~42px desde cada borde para encerrar la escena
	var pasos := 6
	var grosor := 7
	for i in range(pasos):
		var a := (pasos - i) / float(pasos) * 0.075
		var c := Color(0, 0, 0, a)
		var d := i * grosor
		_rect(Vector2(0, d), Vector2(ancho, grosor), c)
		_rect(Vector2(0, alto - d - grosor), Vector2(ancho, grosor), c)
		_rect(Vector2(d, 0), Vector2(grosor, alto), c)
		_rect(Vector2(ancho - d - grosor, 0), Vector2(grosor, alto), c)


func _rect(pos: Vector2, size: Vector2, color: Color) -> void:
	var r := ColorRect.new()
	r.position = pos
	r.size = size
	r.color = color
	_fondo.add_child(r)


func _tex_rect(pos: Vector2, size: Vector2, texture: ImageTexture) -> void:
	var tr := TextureRect.new()
	tr.position = pos
	tr.size = size
	tr.texture = texture
	tr.stretch_mode = TextureRect.STRETCH_TILE
	_fondo.add_child(tr)


func _tex_cantera(tam: Vector2, color_claro: Color, color_oscuro: Color, tile_px: int) -> ImageTexture:
	var image := Image.create(int(tam.x), int(tam.y), false, Image.FORMAT_RGBA8)
	var grout := Color("#B0A490")
	for y in range(int(tam.y)):
		for x in range(int(tam.x)):
			var tx := x % tile_px
			var ty := y % tile_px
			var tile_col := (x / tile_px + y / tile_px) % 2
			var base := color_claro if tile_col == 0 else color_oscuro
			# Grout lines: 2px border on top and left of each tile
			if tx < 2 or ty < 2:
				image.set_pixel(x, y, grout)
			else:
				# Grain: deterministic pseudo-random darkening
				var noise := (x * 7 + y * 13) % 17
				if noise < 3:
					image.set_pixel(x, y, base.darkened(0.07 + noise * 0.02))
				elif noise == 3:
					image.set_pixel(x, y, base.lightened(0.05))
				else:
					image.set_pixel(x, y, base)
	return ImageTexture.create_from_image(image)


func _tex_madera(tam: Vector2, color_base: Color) -> ImageTexture:
	var image := Image.create(int(tam.x), int(tam.y), false, Image.FORMAT_RGBA8)
	var ramp := [
		color_base.darkened(0.30),
		color_base.darkened(0.15),
		color_base,
		color_base.lightened(0.10),
		color_base.lightened(0.22),
	]
	var plank_h := 20
	for y in range(int(tam.y)):
		var plank := y / plank_h
		# Plank separator line
		if y % plank_h == 0:
			for x in range(int(tam.x)):
				image.set_pixel(x, y, color_base.darkened(0.35))
			continue
		for x in range(int(tam.x)):
			var tone_idx := (x * 3 + plank * 5) % ramp.size()
			var c := ramp[tone_idx]
			# Grain pixels
			var noise := (x * 11 + y * 7 + plank * 3) % 19
			if noise == 0:
				c = c.darkened(0.12)
			elif noise == 1:
				c = c.lightened(0.08)
			image.set_pixel(x, y, c)
	return ImageTexture.create_from_image(image)


func _tex_muro(tam: Vector2, color_base: Color) -> ImageTexture:
	var image := Image.create(int(tam.x), int(tam.y), false, Image.FORMAT_RGBA8)
	var h := int(tam.y)
	var w := int(tam.x)
	for y in range(h):
		# Gradient: lighter at top (lit from above), darker at bottom
		var t := float(y) / float(h)
		var row_color := color_base.lightened(0.12 * (1.0 - t)).darkened(0.08 * t)
		for x in range(w):
			# Subtle vertical striping
			var stripe := (x * 3 + y * 2) % 23
			var c := row_color
			if stripe < 2:
				c = c.darkened(0.03)
			elif stripe == 2:
				c = c.lightened(0.02)
			image.set_pixel(x, y, c)
	return ImageTexture.create_from_image(image)


func _tex_alfombra(tam: Vector2, color_base: Color) -> ImageTexture:
	var image := Image.create(int(tam.x), int(tam.y), false, Image.FORMAT_RGBA8)
	var w := int(tam.x)
	var h := int(tam.y)
	var border := 2
	var dark_border := color_base.darkened(0.30)
	var lighter := color_base.lightened(0.10)
	var diamond_color := color_base.darkened(0.18)
	for y in range(h):
		for x in range(w):
			var c: Color
			if x < border or x >= w - border or y < border or y >= h - border:
				c = dark_border
			else:
				# Center highlight
				var cx := abs(x - w / 2)
				var cy := abs(y - h / 2)
				var in_center := cx < w / 4 and cy < h / 4
				# Diamond pattern every 8px
				var dx := x % 8
				var dy := y % 8
				var on_diamond := (dx + dy == 4) or (dx == dy and dx == 4)
				if on_diamond:
					c = diamond_color
				elif in_center:
					c = lighter
				else:
					c = color_base
			image.set_pixel(x, y, c)
	return ImageTexture.create_from_image(image)


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
	# Sombra de contacto en el piso
	_rect(pos + Vector2(2, 28), Vector2(32, 8), Color(0, 0, 0, 0.14))
	# Respaldo con volumen
	_bisel(pos + Vector2(0, -18), Vector2(32, 20), Color("#8B7355"))
	# Asiento con volumen y cojín
	_bisel(pos, Vector2(32, 32), Color("#8B7355"))
	_rect(pos + Vector2(3, 3), Vector2(26, 26), Color("#A08060"))
	_rect(pos + Vector2(5, 5), Vector2(22, 10), Color("#B0906E"))


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
	# Cable y casquillo
	_rect(pos + Vector2(11, 0), Vector2(2, 14), Color("#666666"))
	# Pantalla con bisel metálico
	_bisel(pos, Vector2(24, 12), Color("#C8B878"), 0.25)
	_rect(pos + Vector2(2, 2), Vector2(20, 7), Color("#FFEE99"))
	# Foco encendido (núcleo brillante)
	_rect(pos + Vector2(8, 7), Vector2(8, 4), Color("#FFFBDC"))
	# Cono de luz en capas: amplio y tenue → estrecho e intenso
	_rect(Vector2(pos.x - 26, pos.y + 14), Vector2(76, 66), Color(1.0, 0.95, 0.72, 0.05))
	_rect(Vector2(pos.x - 18, pos.y + 14), Vector2(60, 58), Color(1.0, 0.96, 0.75, 0.06))
	_rect(Vector2(pos.x - 8,  pos.y + 14), Vector2(40, 50), Color(1.0, 0.97, 0.80, 0.07))


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
	# Sombra proyectada del cuadro sobre el muro
	_sombra(pos, tam + Vector2(4, 4), Vector2(3, 4))
	# Marco con bisel dorado (luz arriba-izquierda)
	_bisel(pos, tam + Vector2(4, 4), color_marco, 0.28)
	# Fondo interior con viñeta propia para dar profundidad al lienzo
	_rect(pos + Vector2(4, 4), tam - Vector2(4, 4), color_interior.darkened(0.12))
	_rect(pos + Vector2(6, 6), tam - Vector2(8, 8), color_interior)
	# Reflejo de vidrio en la esquina superior
	_rect(pos + Vector2(5, 5), Vector2((tam.x - 8) * 0.4, 3), Color(1, 1, 1, 0.10))
	if texto != "":
		_label(texto, pos + Vector2(7, 8), 8, color_marco.lightened(0.5), int(tam.x - 10))


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
