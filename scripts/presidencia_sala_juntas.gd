extends "res://scripts/interior_base.gd"


func _dibujar_fondo() -> void:
	# Piso alfombrado con patrón
	_rect(Vector2(0, 0), Vector2(ancho, alto), Color("#6A7A8A"))
	for fy in range(0, alto, 32):
		for fx in range(0, ancho, 32):
			if ((fx / 32) + (fy / 32)) % 2 == 0:
				_rect(Vector2(fx, fy), Vector2(32, 32), Color("#5A6A7A"))
	# Alfombra central debajo de la mesa
	_alfombra(Vector2(96, 140), Vector2(448, 234), Color("#4A5A6A"))

	# Pared norte con moldura
	_rect(Vector2(0, 0), Vector2(ancho, 56), Color("#D8CEB8"))
	_rect(Vector2(0, 52), Vector2(ancho, 6), Color("#C8A860"))
	_rect(Vector2(0, 56), Vector2(ancho, 20), Color("#C4B8A0"))
	_rect(Vector2(0, 74), Vector2(ancho, 4), Color("#A89878"))

	# Zoclos con moldura
	_rect(Vector2(0,   0), Vector2(20, alto), Color("#B0A488"))
	_rect(Vector2(620, 0), Vector2(20, alto), Color("#B0A488"))
	_rect(Vector2(18, 0),  Vector2(4, alto),  Color("#C8A860"))
	_rect(Vector2(618, 0), Vector2(4, alto),  Color("#C8A860"))

	# Lámparas
	_lampara(Vector2(196, 0))
	_lampara(Vector2(296, 0))
	_lampara(Vector2(396, 0))

	# Ventanas con cortinas
	_ventana(Vector2(92, 6))
	_rect(Vector2(84, 4), Vector2(12, 48), Color("#8B6914"))
	_rect(Vector2(142, 4), Vector2(12, 48), Color("#8B6914"))
	_ventana(Vector2(500, 6))
	_rect(Vector2(492, 4), Vector2(12, 48), Color("#8B6914"))
	_rect(Vector2(550, 4), Vector2(12, 48), Color("#8B6914"))

	# Pantalla de proyección con contenido
	_rect(Vector2(176, 8), Vector2(288, 68), Color("#F8F8F8"))
	_rect(Vector2(180, 12), Vector2(280, 60), Color("#E8F0F8"))
	# Contenido de la presentación
	_rect(Vector2(184, 16), Vector2(280, 10), Color("#1A3A6A"))
	_label("PLAN DE DESARROLLO MUNICIPAL 2024-2027", Vector2(185, 18), 7, Color("#FFFFFF"))
	_rect(Vector2(184, 30), Vector2(88, 36), Color("#E8F4FD"))
	_label("Presupuesto\n$48M", Vector2(196, 34), 8, Color("#1A3A6A"))
	_rect(Vector2(278, 30), Vector2(88, 36), Color("#EAF4E8"))
	_label("Obras\n12 proyectos", Vector2(284, 34), 8, Color("#1A5A1A"))
	_rect(Vector2(370, 30), Vector2(88, 36), Color("#FEF5E7"))
	_label("Empleos\n+340", Vector2(382, 34), 8, Color("#7D5A00"))

	# Proyector en el techo
	_rect(Vector2(292, 72), Vector2(56, 18), Color("#2A2A2A"))
	_rect(Vector2(296, 68), Vector2(48, 8), Color("#333333"))
	_rect(Vector2(310, 86), Vector2(20, 3), Color("#FFFF80"))

	# Mesa de juntas grande (ovalada simulada)
	_sombra(Vector2(108, 190), Vector2(432, 152))
	_colision(Vector2(104, 186), Vector2(432, 152))
	_rect(Vector2(116, 186), Vector2(408, 152), Color("#4A2A08"))
	_rect(Vector2(104, 214), Vector2(432, 96), Color("#4A2A08"))
	_rect(Vector2(116, 184), Vector2(408, 14), Color("#6A4018"))
	_rect(Vector2(104, 212), Vector2(4, 100), Color("#6A4018"))
	_rect(Vector2(532, 212), Vector2(4, 100), Color("#6A4018"))
	# Superficie de la mesa
	_rect(Vector2(120, 198), Vector2(400, 132), Color("#5A3410"))
	_rect(Vector2(108, 216), Vector2(424, 92), Color("#5A3410"))
	# Brillo de la mesa
	_rect(Vector2(122, 200), Vector2(398, 10), Color("#7A5028"))
	# Objetos en la mesa
	for mx in range(5):
		_rect(Vector2(134 + mx * 72, 220), Vector2(40, 28), Color("#FFFDF0"))
		_rect(Vector2(134 + mx * 72, 272), Vector2(40, 28), Color("#FFFDF0"))
		_rect(Vector2(160 + mx * 72, 226), Vector2(10, 6), Color("#2A2A2A"))
	# Vasos de agua en la mesa
	for gx in range(4):
		_rect(Vector2(180 + gx * 80, 244), Vector2(12, 18), Color("#87CEEB"))
		_rect(Vector2(182 + gx * 80, 246), Vector2(8, 14), Color("#AED6F1"))
	# Micrófono de mesa
	_rect(Vector2(307, 232), Vector2(6, 20), Color("#333333"))
	_rect(Vector2(303, 228), Vector2(14, 8), Color("#444444"))

	# Sillas alrededor de la mesa (numerosas)
	for sx in [106, 178, 250, 322, 394]:
		_silla(Vector2(sx, 148))
		_silla(Vector2(sx, 352))
	_silla(Vector2(56,  218))
	_silla(Vector2(56,  286))
	_silla(Vector2(544, 218))
	_silla(Vector2(544, 286))

	# Cuadros y decoración
	_cuadro_enmarcado(Vector2(24, 78), Vector2(60, 50), Color("#C8A860"), Color("#1A2A4A"), "Escudo\nMunicipal")
	_cuadro_enmarcado(Vector2(556, 78), Vector2(60, 50), Color("#C8A860"), Color("#1A2A4A"), "Reglamento\nde Sesiones")
	_bandera(Vector2(24, 136))
	_bandera(Vector2(578, 136))

	# Plantas en esquinas
	_planta_grande(Vector2(22, 380))
	_planta_grande(Vector2(600, 380))

	# Puerta de regreso
	_puerta_interior(Vector2(292, 420), "← Recepción")
