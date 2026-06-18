extends "res://scripts/interior_base.gd"


func _dibujar_fondo() -> void:
	# Piso alfombrado gris azulado
	_rect(Vector2(0, 0), Vector2(ancho, alto), Color("#7A8A9A"))
	for fy in range(0, alto, 32):
		for fx in range(0, ancho, 32):
			if ((fx / 32) + (fy / 32)) % 2 == 0:
				_rect(Vector2(fx, fy), Vector2(32, 32), Color("#6A7A8A"))

	# Pared norte
	_rect(Vector2(0, 0), Vector2(ancho, 52), Color("#D8CEB8"))
	_rect(Vector2(0, 52), Vector2(ancho, 20), Color("#C4B8A0"))

	# Zoclos
	_rect(Vector2(0,   0), Vector2(18, alto), Color("#B0A488"))
	_rect(Vector2(622, 0), Vector2(18, alto), Color("#B0A488"))

	# Ventanas
	_ventana(Vector2(100, 8))
	_ventana(Vector2(490, 8))

	# Proyector y pantalla
	_rect(Vector2(180, 10), Vector2(280, 64), Color("#F0F0F0"))
	_rect(Vector2(184, 14), Vector2(272, 56), Color("#E0EEF8"))
	_label("PLAN DE DESARROLLO MUNICIPAL", Vector2(188, 36), 9, Color("#1A3A6A"))

	# Mesa de juntas (grande, ovalada simulada con rects)
	_rect(Vector2(120, 180), Vector2(400, 160), Color("#5A3A10"))
	_rect(Vector2(108, 210), Vector2(424, 100), Color("#5A3A10"))
	_rect(Vector2(120, 178), Vector2(400, 14), Color("#7A5020"))
	# Superficie de la mesa
	_rect(Vector2(124, 184), Vector2(392, 148), Color("#6A4418"))

	# Sillas alrededor de la mesa
	for sx in [100, 175, 250, 325, 400]:
		_silla(Vector2(sx, 148))   # arriba
		_silla(Vector2(sx, 340))   # abajo
	_silla(Vector2(60,  220))
	_silla(Vector2(60,  280))
	_silla(Vector2(524, 220))
	_silla(Vector2(524, 280))

	# Proyector en el techo (colgando)
	_rect(Vector2(295, 75), Vector2(50, 20), Color("#333333"))

	# Macetas en esquinas
	_maceta(Vector2(22,  80))
	_maceta(Vector2(598, 80))
	_maceta(Vector2(22,  400))
	_maceta(Vector2(598, 400))

	# Puerta de regreso
	_puerta_interior(Vector2(292, 420), "Recepción")
