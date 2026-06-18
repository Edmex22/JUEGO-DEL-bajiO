extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso clínico blanco con línea central
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			_rect(Vector2(fx, fy), Vector2(40, 40), Color("#F0F4F8"))
	# Línea de orientación en el piso (azul)
	_rect(Vector2(0, 200), Vector2(ancho, 6), Color("#3498DB"))
	_rect(Vector2(0, 280), Vector2(ancho, 6), Color("#E74C3C"))

	# Pared norte
	_rect(Vector2(0, 0), Vector2(ancho, 56), Color("#FFFFFF"))
	_rect(Vector2(0, 52), Vector2(ancho, 8), Color("#BDC3C7"))

	# Zoclos
	_rect(Vector2(0, 0),   Vector2(18, alto), Color("#D5D8DC"))
	_rect(Vector2(622, 0), Vector2(18, alto), Color("#D5D8DC"))

	# Cruz roja
	_rect(Vector2(290, 10), Vector2(60, 18), Color("#E74C3C"))
	_rect(Vector2(305, 4),  Vector2(30, 30), Color("#E74C3C"))

	# Letrero
	_label("HOSPITAL GENERAL", Vector2(178, 34), 13, Color("#2C3E50"))

	# Mostrador de recepción / admisiones
	_rect(Vector2(140, 100), Vector2(360, 48), Color("#BDC3C7"))
	_rect(Vector2(140, 90),  Vector2(360, 12), Color("#95A5A6"))
	_label("ADMISIONES", Vector2(268, 100), 11, Color("#2C3E50"))

	# Sillas de espera
	for sx in range(5):
		_silla(Vector2(40 + sx * 50, 200))
	for sx in range(5):
		_silla(Vector2(40 + sx * 50, 300))

	# Paneles de camillas / consultorios (lado derecho)
	_rect(Vector2(490, 100), Vector2(110, 120), Color("#ECF0F1"))
	_rect(Vector2(496, 106), Vector2(98, 108), Color("#D6EAF8"))
	_label("Urgencias", Vector2(506, 160), 9, Color("#C0392B"))

	_rect(Vector2(490, 240), Vector2(110, 100), Color("#ECF0F1"))
	_rect(Vector2(496, 246), Vector2(98, 88),  Color("#D5F5E3"))
	_label("Consulta\nGeneral", Vector2(510, 272), 9, Color("#1A5276"))

	# Puerta a quirófano
	_puerta_interior(Vector2(520, 360), "Quirófano")

	# Puerta de salida
	_rect(Vector2(284, 432), Vector2(72, 48), Color("#2980B9"))
	_label("Salida", Vector2(300, 446), 10, Color("#FFFFFF"))

	# Dispensador de gel
	_rect(Vector2(30,  100), Vector2(16, 28), Color("#3498DB"))
	_rect(Vector2(598, 100), Vector2(16, 28), Color("#3498DB"))
