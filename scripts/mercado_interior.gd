extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso de loseta colorida
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			var c := Color("#E8D8B0") if ((fx/40 + fy/40) % 2 == 0) else Color("#D4C49C")
			_rect(Vector2(fx, fy), Vector2(40, 40), c)

	# Techo / arcos de entrada (pared norte)
	_rect(Vector2(0, 0), Vector2(ancho, 52), Color("#C8854A"))
	for ax in [60, 180, 300, 420, 520]:
		_rect(Vector2(ax, 4), Vector2(60, 44), Color("#D4986A"))
		_rect(Vector2(ax+6, 8), Vector2(48, 36), Color("#E8B080"))

	# Zoclos laterales
	_rect(Vector2(0, 0),   Vector2(20, alto), Color("#A06030"))
	_rect(Vector2(620, 0), Vector2(20, alto), Color("#A06030"))

	# Puestos de mercado — 3 filas de puestos
	_puesto(Vector2(40,  100), Color("#E74C3C"), "Frutas y\nVerduras")
	_puesto(Vector2(200, 100), Color("#F39C12"), "Carnicería")
	_puesto(Vector2(360, 100), Color("#27AE60"), "Hierbas y\nEspecias")
	_puesto(Vector2(520, 100), Color("#3498DB"), "Pescadería")

	_puesto(Vector2(40,  240), Color("#8E44AD"), "Ropa y\nTelas")
	_puesto(Vector2(200, 240), Color("#E67E22"), "Panadería")
	_puesto(Vector2(360, 240), Color("#16A085"), "Artesanías")
	_puesto(Vector2(520, 240), Color("#C0392B"), "Dulces")

	# Pasillo central
	_rect(Vector2(0, 210), Vector2(ancho, 24), Color("#D4C49C"))

	# Puerta a bodega (atrás)
	_puerta_interior(Vector2(292, 380), "Bodega")

	# Puerta de salida
	_rect(Vector2(284, 432), Vector2(72, 48), Color("#5A3020"))
	_label("Salida", Vector2(300, 446), 10, Color("#FFD080"))

	# Macetas y plantas decorativas
	_maceta(Vector2(22,  100))
	_maceta(Vector2(598, 100))
	_maceta(Vector2(22,  340))
	_maceta(Vector2(598, 340))

	# Letrero colgante
	_label("MERCADO MUNICIPAL", Vector2(168, 56), 13, Color("#FFFFFF"))
	_label("San Brasa del Monte", Vector2(210, 72), 9, Color("#FFE0A0"))


func _puesto(pos: Vector2, color: Color, nombre: String) -> void:
	# Base del puesto
	_rect(pos, Vector2(100, 90), Color("#8B5E2A"))
	# Toldo
	_rect(pos + Vector2(0, -18), Vector2(100, 20), color)
	# Superficie con productos
	_rect(pos + Vector2(4, 8), Vector2(92, 50), color.lightened(0.4))
	# Nombre del puesto
	var l := Label.new()
	l.text = nombre
	l.position = pos + Vector2(2, 55)
	l.add_theme_font_size_override("font_size", 8)
	l.add_theme_color_override("font_color", Color("#3A2010"))
	l.size = Vector2(96, 32)
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_fondo.add_child(l)
