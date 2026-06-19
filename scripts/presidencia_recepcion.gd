extends "res://scripts/interior_base.gd"


func _dibujar_fondo() -> void:
	# Piso de cantera en cuadrícula con grout
	for fy in range(0, alto, 48):
		for fx in range(0, ancho, 48):
			var dark := ((fx / 48) + (fy / 48)) % 2 == 0
			_rect(Vector2(fx, fy), Vector2(48, 48), Color("#CBBFA8") if dark else Color("#D8CCB4"))
			# Líneas de grout
			_rect(Vector2(fx, fy), Vector2(48, 2), Color("#B0A490"))
			_rect(Vector2(fx, fy), Vector2(2, 48), Color("#B0A490"))

	# Pared norte con moldura
	_rect(Vector2(0, 0), Vector2(ancho, 68), Color("#EAE0CC"))
	_rect(Vector2(0, 62), Vector2(ancho, 4), Color("#C8A860"))
	_rect(Vector2(0, 66), Vector2(ancho, 2), Color("#8B7340"))

	# Zoclos laterales con moldura
	_rect(Vector2(0, 0),   Vector2(20, alto), Color("#C8BC9A"))
	_rect(Vector2(620, 0), Vector2(20, alto), Color("#C8BC9A"))
	_rect(Vector2(18, 0),  Vector2(3, alto),  Color("#B0A480"))
	_rect(Vector2(619, 0), Vector2(3, alto),  Color("#B0A480"))

	# Alfombra de espera
	_alfombra(Vector2(30, 230), Vector2(200, 160), Color("#8B1A1A"))

	# Ventanas con cortinas
	for wx in [70, 270, 470]:
		_ventana(Vector2(wx, 8))
		# Cortinas
		_rect(Vector2(wx - 8, 6), Vector2(10, 42), Color("#C8A860"))
		_rect(Vector2(wx + 50, 6), Vector2(10, 42), Color("#C8A860"))

	# Lámparas de techo
	_lampara(Vector2(96, 0))
	_lampara(Vector2(296, 0))
	_lampara(Vector2(496, 0))

	# Banderas (México + municipal)
	_bandera(Vector2(280, 70))
	_bandera(Vector2(340, 70))

	# Escudo / título con fondo
	_rect(Vector2(150, 68), Vector2(340, 34), Color("#EAE0CC"))
	_label("PRESIDENCIA MUNICIPAL", Vector2(162, 72), 13, Color("#5A3A10"))
	_label("H. Ayuntamiento de San Brasa del Monte", Vector2(172, 88), 7, Color("#7A5A30"))

	# Cuadros con marcos dorados
	_cuadro_enmarcado(Vector2(24, 90), Vector2(60, 44), Color("#C8A860"), Color("#2C4A8A"), "Constitución\nMunicipal")
	_cuadro_enmarcado(Vector2(556, 90), Vector2(60, 44), Color("#C8A860"), Color("#4A2C2C"), "Plan de\nDesarrollo")
	_cuadro_enmarcado(Vector2(24, 170), Vector2(56, 40), Color("#8B6914"), Color("#1A3A1A"), "Reglamento\nInterno")

	# Columnas decorativas
	_columna(Vector2(148, 68), 380)
	_columna(Vector2(490, 68), 380)

	# Mostrador de recepción mejorado
	_mostrador(Vector2(155, 155), 330, Color("#8B6914"))
	# Teléfono sobre mostrador
	_rect(Vector2(190, 145), Vector2(28, 10), Color("#222222"))
	_rect(Vector2(193, 143), Vector2(22, 4), Color("#333333"))
	# Monitor
	_rect(Vector2(390, 130), Vector2(40, 28), Color("#1A1A1A"))
	_rect(Vector2(393, 133), Vector2(34, 20), Color("#3A9FD4"))
	_rect(Vector2(405, 158), Vector2(10, 6), Color("#2A2A2A"))
	# Teclado
	_rect(Vector2(388, 162), Vector2(44, 8), Color("#333333"))
	# Letrero de recepción
	_rect(Vector2(248, 160), Vector2(144, 16), Color("#A07820"))
	_label("RECEPCIÓN", Vector2(272, 163), 9, Color("#FFE080"))

	# Numerador de ventanilla
	_rect(Vector2(248, 105), Vector2(144, 28), Color("#1A1A1A"))
	_rect(Vector2(252, 109), Vector2(136, 20), Color("#222222"))
	_label("TURNO: B-017", Vector2(268, 113), 9, Color("#00FF00"))

	# Sillas de espera con mesa central
	_silla(Vector2(38, 250))
	_silla(Vector2(80, 250))
	_silla(Vector2(122, 250))
	_silla(Vector2(38, 320))
	_silla(Vector2(80, 320))
	_silla(Vector2(122, 320))
	# Mesa de centro
	_rect(Vector2(62, 290), Vector2(56, 28), Color("#6B4A20"))
	_rect(Vector2(64, 292), Vector2(52, 24), Color("#8B6A30"))
	# Revista en la mesa
	_rect(Vector2(68, 294), Vector2(24, 18), Color("#E74C3C"))
	_label("Ley", Vector2(72, 297), 6, Color("#FFFFFF"))

	# Plantas grandes en esquinas
	_planta_grande(Vector2(24, 110))
	_planta_grande(Vector2(592, 110))
	_planta_grande(Vector2(24, 370))
	_planta_grande(Vector2(592, 370))

	# Puerta al Despacho del Presidente
	_puerta_interior(Vector2(292, 84), "Despacho del Presidente")

	# Puerta a Sala de Juntas
	_puerta_interior(Vector2(536, 200), "Sala de Juntas")

	# Puerta de Salida (sur) más detallada
	_rect(Vector2(280, 424), Vector2(80, 56), Color("#5A3020"))
	_rect(Vector2(284, 428), Vector2(34, 48), Color("#6B3A28"))
	_rect(Vector2(322, 428), Vector2(34, 48), Color("#6B3A28"))
	_rect(Vector2(315, 452), Vector2(10, 10), Color("#C8A860"))
	_label("↓  Salida", Vector2(294, 444), 10, Color("#FFD080"))
