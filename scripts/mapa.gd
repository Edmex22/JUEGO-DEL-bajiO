extends Node2D

const COLS: int = 20
const FILAS: int = 20

# Paleta día (del documento técnico)
const COLOR_PASTO   := Color("#7CBA5F")
const COLOR_BORDE   := Color("#5A9A3F")
const COLOR_CAMINO  := Color("#6B6B6B")
const COLOR_BORDE_C := Color("#4A4A4A")

# Celdas que son camino (col, fila)
const _CAMINOS := [
	Vector2i(9,0), Vector2i(9,1), Vector2i(9,2), Vector2i(9,3),
	Vector2i(9,4), Vector2i(9,5), Vector2i(9,6), Vector2i(9,7),
	Vector2i(9,8), Vector2i(9,9), Vector2i(9,10), Vector2i(9,11),
	Vector2i(9,12), Vector2i(9,13), Vector2i(9,14), Vector2i(9,15),
	Vector2i(9,16), Vector2i(9,17), Vector2i(9,18), Vector2i(9,19),
	Vector2i(0,9), Vector2i(1,9), Vector2i(2,9), Vector2i(3,9),
	Vector2i(4,9), Vector2i(5,9), Vector2i(6,9), Vector2i(7,9),
	Vector2i(8,9), Vector2i(10,9), Vector2i(11,9), Vector2i(12,9),
	Vector2i(13,9), Vector2i(14,9), Vector2i(15,9), Vector2i(16,9),
	Vector2i(17,9), Vector2i(18,9), Vector2i(19,9),
]


func _draw() -> void:
	for fila in range(FILAS):
		for col in range(COLS):
			var centro := GridIso.grid_a_pantalla(col, fila)
			var es_camino := Vector2i(col, fila) in _CAMINOS
			var color := COLOR_CAMINO if es_camino else COLOR_PASTO
			var borde := COLOR_BORDE_C if es_camino else COLOR_BORDE
			_dibujar_tile(centro, color, borde)


func _dibujar_tile(centro: Vector2, relleno: Color, borde: Color) -> void:
	var verts := GridIso.vertices_rombo(centro)
	draw_colored_polygon(verts, PackedColorArray([relleno, relleno, relleno, relleno]))
	# Borde
	draw_line(verts[0], verts[1], borde, 1.0)
	draw_line(verts[1], verts[2], borde, 1.0)
	draw_line(verts[2], verts[3], borde, 1.0)
	draw_line(verts[3], verts[0], borde, 1.0)
