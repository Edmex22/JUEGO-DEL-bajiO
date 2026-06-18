extends Node

# Tamaño de cada tile isométrico en píxeles
const TILE_W: int = 64  # ancho del rombo
const TILE_H: int = 32  # alto del rombo (proporción 2:1)

# Convierte coordenadas de grid (col, fila) a posición en pantalla
static func grid_a_pantalla(col: int, fila: int) -> Vector2:
	return Vector2(
		(col - fila) * TILE_W / 2.0,
		(col + fila) * TILE_H / 2.0
	)

# Convierte posición en pantalla a coordenadas de grid (aproximado)
static func pantalla_a_grid(pos: Vector2) -> Vector2i:
	var col := int(round(pos.x / (TILE_W / 2.0) + pos.y / (TILE_H / 2.0)) / 2.0)
	var fila := int(round(pos.y / (TILE_H / 2.0) - pos.x / (TILE_W / 2.0)) / 2.0)
	return Vector2i(col, fila)

# Devuelve los 4 vértices del rombo de un tile para dibujarlo
static func vertices_rombo(centro: Vector2) -> PackedVector2Array:
	var hw := TILE_W / 2.0
	var hh := TILE_H / 2.0
	return PackedVector2Array([
		Vector2(centro.x,      centro.y - hh),  # arriba
		Vector2(centro.x + hw, centro.y),        # derecha
		Vector2(centro.x,      centro.y + hh),   # abajo
		Vector2(centro.x - hw, centro.y),         # izquierda
	])
