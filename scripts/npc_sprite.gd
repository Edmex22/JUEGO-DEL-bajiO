extends Node2D

# Color de camisa configurable desde el padre
@export var color_camisa: Color = Color("#3498DB")
@export var color_pantalon: Color = Color("#2C3E50")


func _draw() -> void:
	# Cuerpo (torso)
	draw_rect(Rect2(-5, -14, 10, 12), color_camisa)
	# Pantalón
	draw_rect(Rect2(-5, -2, 4, 8),  color_pantalon)
	draw_rect(Rect2(1,  -2, 4, 8),  color_pantalon)
	# Cabeza
	draw_circle(Vector2(0, -20), 6, Color("#F0C27F"))
	# Pelo
	draw_arc(Vector2(0, -20), 6, PI, 2 * PI, 8, Color("#4A2C00"), 3.0)
	# Ojos
	draw_circle(Vector2(-2, -21), 1.0, Color("#1A1A1A"))
	draw_circle(Vector2(2,  -21), 1.0, Color("#1A1A1A"))
	# Brazos
	draw_line(Vector2(-5, -13), Vector2(-8, -6), color_camisa, 3.0)
	draw_line(Vector2(5,  -13), Vector2(8,  -6), color_camisa, 3.0)
