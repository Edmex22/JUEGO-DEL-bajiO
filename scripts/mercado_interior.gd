extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso de loseta colorida con grout
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			var c := Color("#E8D8B0") if ((fx/40 + fy/40) % 2 == 0) else Color("#D4C49C")
			_rect(Vector2(fx, fy), Vector2(40, 40), c)
			_rect(Vector2(fx, fy), Vector2(40, 2), Color("#C0AA80"))
			_rect(Vector2(fx, fy), Vector2(2, 40), Color("#C0AA80"))

	# Techo / arcos de entrada colonial
	_rect(Vector2(0, 0), Vector2(ancho, 56), Color("#B87040"))
	for ax in [40, 160, 280, 400, 520]:
		_rect(Vector2(ax, 3), Vector2(72, 50), Color("#C8804A"))
		_rect(Vector2(ax + 6, 7), Vector2(60, 42), Color("#D89060"))
		# Detalle del arco
		_rect(Vector2(ax + 28, 3), Vector2(16, 50), Color("#B87040"))

	# Zoclos laterales con detalle
	_rect(Vector2(0, 0),   Vector2(22, alto), Color("#8B5030"))
	_rect(Vector2(618, 0), Vector2(22, alto), Color("#8B5030"))
	_rect(Vector2(20, 0),  Vector2(4, alto),  Color("#C07050"))

	# Letrero central colgante
	_rect(Vector2(200, 4), Vector2(240, 28), Color("#5A2A00"))
	_rect(Vector2(204, 8), Vector2(232, 20), Color("#8B4A00"))
	_label("✦ MERCADO MUNICIPAL ✦", Vector2(210, 12), 11, Color("#FFD080"))
	_label("San Brasa del Monte", Vector2(248, 34), 8, Color("#FFE0A0"))

	# Lámparas colgantes sobre cada pasillo
	for lx in [96, 220, 320, 420, 524]:
		_lampara(Vector2(lx, 0))

	# Puestos de mercado — fila norte
	_puesto(Vector2(30,  90), Color("#E74C3C"), "Frutas y\nVerduras")
	_puesto(Vector2(170, 90), Color("#F39C12"), "Carnicería")
	_puesto(Vector2(310, 90), Color("#27AE60"), "Hierbas y\nEspecias")
	_puesto(Vector2(450, 90), Color("#3498DB"), "Pescadería")

	# Pasillo central con líneas
	_rect(Vector2(0, 206), Vector2(ancho, 28), Color("#C8B890"))
	_rect(Vector2(0, 208), Vector2(ancho, 4), Color("#B0A070"))
	_rect(Vector2(0, 228), Vector2(ancho, 4), Color("#B0A070"))

	# Puestos de mercado — fila sur
	_puesto(Vector2(30,  260), Color("#8E44AD"), "Ropa y\nTelas")
	_puesto(Vector2(170, 260), Color("#E67E22"), "Panadería")
	_puesto(Vector2(310, 260), Color("#16A085"), "Artesanías")
	_puesto(Vector2(450, 260), Color("#C0392B"), "Dulces")

	# Puesto extra en el lado derecho
	_puesto(Vector2(548, 90),  Color("#795548"), "Tortillería")
	_puesto(Vector2(548, 260), Color("#607D8B"), "Ferretería")

	# Plantas decorativas en pasillos
	_maceta(Vector2(24,  200))
	_maceta(Vector2(610, 200))
	_planta_grande(Vector2(24,  90))
	_planta_grande(Vector2(612, 90))

	# Columnas decorativas
	_columna(Vector2(140, 56), 200)
	_columna(Vector2(280, 56), 200)
	_columna(Vector2(420, 56), 200)
	_columna(Vector2(560, 56), 200)

	# Puerta de salida mejorada
	_rect(Vector2(276, 424), Vector2(88, 56), Color("#6B3A1A"))
	_rect(Vector2(280, 428), Vector2(36, 48), Color("#7A4828"))
	_rect(Vector2(320, 428), Vector2(36, 48), Color("#7A4828"))
	_rect(Vector2(312, 450), Vector2(12, 12), Color("#C8A860"))
	_label("↓  Salida", Vector2(292, 444), 10, Color("#FFD080"))


func _puesto(pos: Vector2, color: Color, nombre: String) -> void:
	# Sombra del puesto
	_rect(pos + Vector2(4, 4), Vector2(108, 96), Color(0, 0, 0, 0.2))
	# Base del puesto
	_rect(pos, Vector2(106, 94), Color("#6B4A1A"))
	# Tablero trasero
	_rect(pos + Vector2(2, 2), Vector2(102, 60), Color("#7A5A28"))
	# Toldo con franjas
	_rect(pos + Vector2(0, -22), Vector2(106, 24), color.darkened(0.2))
	_rect(pos + Vector2(0, -22), Vector2(106, 8),  color)
	_rect(pos + Vector2(0, -14), Vector2(106, 8),  color.darkened(0.1))
	_rect(pos + Vector2(0, -6),  Vector2(106, 8),  color)
	# Superficie con productos (color)
	_rect(pos + Vector2(4, 8), Vector2(98, 46), color.lightened(0.35))
	# Productos simulados (puntos de color)
	for py in range(2):
		for px in range(4):
			_rect(pos + Vector2(8 + px * 22, 14 + py * 18), Vector2(14, 12), color.lightened(0.5))
	# Nombre del puesto
	var l := Label.new()
	l.text = nombre
	l.position = pos + Vector2(2, 62)
	l.add_theme_font_size_override("font_size", 8)
	l.add_theme_color_override("font_color", Color("#3A2010"))
	l.size = Vector2(102, 28)
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_fondo.add_child(l)
	# Precio
	_rect(pos + Vector2(4, 80), Vector2(98, 12), color.darkened(0.3))
	_label("$", pos + Vector2(8, 81), 8, Color("#FFD080"))
