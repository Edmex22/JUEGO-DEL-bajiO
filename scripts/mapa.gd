extends Node2D

const COLS:  int = 40
const FILAS: int = 40

const COLOR_PASTO   := Color("#7CBA5F")
const COLOR_BORDE   := Color("#5A9A3F")
const COLOR_CAMINO  := Color("#6B6B6B")
const COLOR_BORDE_C := Color("#4A4A4A")
const COLOR_BANQUETA := Color("#C8C0A8")
const COLOR_PLAZA   := Color("#D4C89A")

# Calles principales: columna 19 (vertical) y fila 19 (horizontal)
# Calles secundarias: col 9, col 29, fila 9, fila 29
# Plaza central: cols 17-21, filas 17-21

func _draw() -> void:
	for fila in range(FILAS):
		for col in range(COLS):
			var centro := GridIso.grid_a_pantalla(col, fila)
			var color  := _color_tile(col, fila)
			var borde  := _borde_tile(col, fila)
			_dibujar_tile(centro, color, borde)


func _color_tile(col: int, fila: int) -> Color:
	# Plaza central
	if col >= 17 and col <= 21 and fila >= 17 and fila <= 21:
		return COLOR_PLAZA
	# Calles principales
	if col == 19 or fila == 19:
		return COLOR_CAMINO
	# Calles secundarias
	if col == 9 or col == 29 or fila == 9 or fila == 29:
		return COLOR_CAMINO
	# Banquetas (adyacentes a calles principales)
	if col == 18 or col == 20 or fila == 18 or fila == 20:
		return COLOR_BANQUETA
	if col == 8 or col == 10 or col == 28 or col == 30:
		return COLOR_BANQUETA
	if fila == 8 or fila == 10 or fila == 28 or fila == 30:
		return COLOR_BANQUETA
	return COLOR_PASTO


func _borde_tile(col: int, fila: int) -> Color:
	if col == 19 or fila == 19 or col == 9 or col == 29 or fila == 9 or fila == 29:
		return COLOR_BORDE_C
	return COLOR_BORDE


func _dibujar_tile(centro: Vector2, relleno: Color, borde: Color) -> void:
	var verts := GridIso.vertices_rombo(centro)
	draw_colored_polygon(verts, relleno)
	draw_line(verts[0], verts[1], borde, 1.0)
	draw_line(verts[1], verts[2], borde, 1.0)
	draw_line(verts[2], verts[3], borde, 1.0)
	draw_line(verts[3], verts[0], borde, 1.0)
