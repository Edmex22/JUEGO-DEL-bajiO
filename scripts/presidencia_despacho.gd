extends "res://scripts/interior_base.gd"


func _dibujar_fondo() -> void:
	# Piso de madera (franjas horizontales)
	for fy in range(0, alto, 24):
		var tono := 0.05 if (fy / 24) % 3 == 0 else 0.0
		_rect(Vector2(0, fy), Vector2(ancho, 24),
			Color(0.40 + tono, 0.26 + tono, 0.08 + tono))

	# Pared norte de caoba oscura
	_rect(Vector2(0, 0), Vector2(ancho, 56), Color("#3C1F0A"))
	# Wainscoting (zoclos altos)
	_rect(Vector2(0, 56), Vector2(ancho, 24), Color("#5A3015"))

	# Zoclos laterales
	_rect(Vector2(0,   0), Vector2(22, alto), Color("#4A2A0A"))
	_rect(Vector2(618, 0), Vector2(22, alto), Color("#4A2A0A"))

	# Ventana grande con vista (simulada)
	_rect(Vector2(240, 8), Vector2(160, 44), Color("#3A6A8A"))
	_rect(Vector2(244, 12), Vector2(68, 36), Color("#5A9FBF"))
	_rect(Vector2(328, 12), Vector2(68, 36), Color("#5A9FBF"))
	_rect(Vector2(308, 8),  Vector2(8,  44), Color("#C8A870"))

	# Bandera grande
	_bandera(Vector2(560, 60))

	# Escritorio presidencial (grande)
	_rect(Vector2(200, 180), Vector2(240, 80), Color("#5A3010"))
	_rect(Vector2(200, 168), Vector2(240, 14), Color("#7A4A20"))
	# Papeles y objetos
	_rect(Vector2(215, 182), Vector2(50, 35), Color("#FFFDF0"))
	_rect(Vector2(270, 185), Vector2(40, 28), Color("#F0EFE8"))
	_rect(Vector2(350, 182), Vector2(30, 20), Color("#1A1A1A"))  # teléfono
	_rect(Vector2(320, 178), Vector2(48, 32), Color("#222222"))  # laptop
	_rect(Vector2(324, 182), Vector2(40, 24), Color("#2A6AAA"))

	# Silla presidencial (detrás del escritorio)
	_rect(Vector2(288, 248), Vector2(64, 48), Color("#722222"))
	_rect(Vector2(292, 252), Vector2(56, 40), Color("#8A2A2A"))
	_rect(Vector2(288, 228), Vector2(64, 22), Color("#722222"))

	# Sillas para visitas (frente al escritorio)
	_silla(Vector2(220, 300))
	_silla(Vector2(350, 300))

	# Librero lateral
	_rect(Vector2(30, 80), Vector2(80, 200), Color("#3A1A05"))
	for ry in range(0, 5):
		for rx in range(0, 3):
			var c := [Color("#8A2020"), Color("#2020AA"), Color("#206A20"),
					  Color("#AA8820"), Color("#602060")].pick_random()
			_rect(Vector2(34 + rx * 24, 88 + ry * 36), Vector2(20, 32), c)

	# Cuadro del presidente (retrato)
	_rect(Vector2(250, 8), Vector2(140, 10), Color("#8A7A50"))  # marco superior
	_label("Presidente Municipal", Vector2(230, 60), 8, Color("#C8A870"))

	# Alfombra de regreso
	_rect(Vector2(160, 360), Vector2(320, 80), Color("#8A2020"))
	_rect(Vector2(168, 368), Vector2(304, 64), Color("#AA3030"))

	# Puerta de regreso a Recepción
	_puerta_interior(Vector2(292, 420), "Recepción")
