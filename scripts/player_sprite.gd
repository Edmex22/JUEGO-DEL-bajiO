extends Node2D

# Sprite isométrico del jugador dibujado en código
# Personaje simple: cuerpo en bloque iso + cabeza + detalles

var _direccion: String = "sur"  # norte/sur/este/oeste

func _draw() -> void:
	match _direccion:
		"sur", "norte": _dibujar_frente()
		"este", "oeste": _dibujar_lado()


func _dibujar_frente() -> void:
	# Sombra
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, 2), Vector2(10, 6), Vector2(0, 10), Vector2(-10, 6)
	]), Color(0, 0, 0, 0.25))

	# Piernas (dos bloques pequeños)
	draw_colored_polygon(PackedVector2Array([
		Vector2(-6, -2), Vector2(0, 2), Vector2(0, 10), Vector2(-6, 6)
	]), Color("#1A5276"))  # pierna izq - cara izq
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, 2), Vector2(6, -2), Vector2(6, 6), Vector2(0, 10)
	]), Color("#2471A3"))  # pierna der - cara der

	# Cuerpo - cara izquierda
	draw_colored_polygon(PackedVector2Array([
		Vector2(-10, -14), Vector2(0, -10), Vector2(0, 2), Vector2(-10, -2)
	]), Color("#E74C3C"))
	# Cuerpo - cara derecha
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, -10), Vector2(10, -14), Vector2(10, -2), Vector2(0, 2)
	]), Color("#C0392B"))
	# Cuerpo - techo (hombros)
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, -18), Vector2(10, -14), Vector2(0, -10), Vector2(-10, -14)
	]), Color("#F1948A"))

	# Cabeza
	draw_circle(Vector2(0, -24), 7.0, Color("#F5CBA7"))
	# Ojos
	draw_circle(Vector2(-2, -25), 1.5, Color("#1A1A1A"))
	draw_circle(Vector2(3,  -25), 1.5, Color("#1A1A1A"))
	# Pelo
	draw_colored_polygon(PackedVector2Array([
		Vector2(-7, -27), Vector2(7, -27), Vector2(5, -31), Vector2(-5, -31)
	]), Color("#5D4037"))


func _dibujar_lado() -> void:
	# Sombra
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, 2), Vector2(10, 6), Vector2(0, 10), Vector2(-10, 6)
	]), Color(0, 0, 0, 0.25))

	# Pierna
	draw_colored_polygon(PackedVector2Array([
		Vector2(-8, 0), Vector2(8, 0), Vector2(8, 10), Vector2(-8, 10)
	]), Color("#1A5276"))

	# Cuerpo lateral
	draw_colored_polygon(PackedVector2Array([
		Vector2(-8, -14), Vector2(8, -14), Vector2(8, 0), Vector2(-8, 0)
	]), Color("#E74C3C"))

	# Cabeza
	draw_circle(Vector2(0, -21), 7.0, Color("#F5CBA7"))
	draw_circle(Vector2(3, -22), 1.5, Color("#1A1A1A"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(-7, -25), Vector2(7, -25), Vector2(5, -29), Vector2(-5, -29)
	]), Color("#5D4037"))
