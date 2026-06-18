extends Node2D

const COLS:  int = 44
const FILAS: int = 44

const COLOR_PASTO    := Color("#7CBA5F")
const COLOR_BORDE    := Color("#5A9A3F")
const COLOR_CAMINO   := Color("#787060")
const COLOR_BORDE_C  := Color("#504840")
const COLOR_BANQUETA := Color("#C8C0A8")
const COLOR_PLAZA    := Color("#D4C090")
const COLOR_PLAZA2   := Color("#C8B480")
const COLOR_TIERRA   := Color("#9C7A50")

# ── Layout de calles (irregulares, como ciudad real) ──────────────────────────
# Calles verticales (columnas): anchos irregulares entre manzanas
const CALLES_COL := [5, 6, 13, 21, 22, 30, 37, 38]
# Calles horizontales (filas)
const CALLES_FILA := [5, 6, 14, 21, 22, 29, 37, 38]

# Plaza central: gran espacio cívico
# Rectángulo de cols 15–29, filas 15–28 en coordenadas de grid
const PLAZA_C0 := 15
const PLAZA_C1 := 28
const PLAZA_F0 := 15
const PLAZA_F1 := 28


func _draw() -> void:
	for fila in range(FILAS):
		for col in range(COLS):
			var centro := GridIso.grid_a_pantalla(col, fila)
			var color  := _color_tile(col, fila)
			var borde  := _borde_tile(col, fila)
			_dibujar_tile(centro, color, borde)


func _color_tile(col: int, fila: int) -> Color:
	# ── Plaza central ─────────────────────────────────────────────────────────
	if col >= PLAZA_C0 and col <= PLAZA_C1 and fila >= PLAZA_F0 and fila <= PLAZA_F1:
		# Patrón de baldosas dentro de la plaza
		var dentro_x := col - PLAZA_C0
		var dentro_y := fila - PLAZA_F0
		# Borde de la plaza (3 tiles de ancho)
		if dentro_x < 2 or dentro_x > (PLAZA_C1 - PLAZA_C0 - 2) \
		or dentro_y < 2 or dentro_y > (PLAZA_F1 - PLAZA_F0 - 2):
			return Color("#B8A870")   # borde de cantera oscura
		# Centro de la plaza: patrón de cuadrícula
		if (dentro_x + dentro_y) % 3 == 0:
			return COLOR_PLAZA2
		return COLOR_PLAZA

	# ── Calles ───────────────────────────────────────────────────────────────
	if col in CALLES_COL or fila in CALLES_FILA:
		return COLOR_CAMINO

	# ── Banquetas (tiles adyacentes a calles) ─────────────────────────────────
	for c in CALLES_COL:
		if abs(col - c) == 1:
			return COLOR_BANQUETA
	for f in CALLES_FILA:
		if abs(fila - f) == 1:
			return COLOR_BANQUETA

	# ── Tierra / lotes vacíos en esquinas ────────────────────────────────────
	if (col < 4 and fila < 4) or (col > 39 and fila > 39):
		return COLOR_TIERRA

	return COLOR_PASTO


func _borde_tile(col: int, fila: int) -> Color:
	if col in CALLES_COL or fila in CALLES_FILA:
		return COLOR_BORDE_C
	if col >= PLAZA_C0 and col <= PLAZA_C1 and fila >= PLAZA_F0 and fila <= PLAZA_F1:
		return Color("#A09060")
	return COLOR_BORDE


func _dibujar_tile(centro: Vector2, relleno: Color, borde: Color) -> void:
	var verts := GridIso.vertices_rombo(centro)
	draw_colored_polygon(verts, relleno)
	draw_line(verts[0], verts[1], borde, 0.8)
	draw_line(verts[1], verts[2], borde, 0.8)
	draw_line(verts[2], verts[3], borde, 0.8)
	draw_line(verts[3], verts[0], borde, 0.8)
