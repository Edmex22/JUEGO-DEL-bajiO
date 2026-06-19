extends "res://scripts/interior_base.gd"


func _agregar_paredes() -> void:
	# Norte completo (sin puertas aquí)
	_colision(Vector2(0, 0), Vector2(ancho, 92))
	# Oeste: gap para puerta al Despacho (y=200, alto=72 → 200 a 272)
	_colision(Vector2(0, 0), Vector2(22, 200))
	_colision(Vector2(0, 272), Vector2(22, alto - 272))
	# Este: gap para puerta a Sala de Juntas (y=220, alto=72 → 220 a 292)
	_colision(Vector2(ancho - 22, 0), Vector2(22, 220))
	_colision(Vector2(ancho - 22, 292), Vector2(22, alto - 292))
	# Sur con paso central
	_colision(Vector2(0, alto - 20), Vector2(260, 20))
	_colision(Vector2(380, alto - 20), Vector2(260, 20))


func _dibujar_fondo() -> void:
	# Piso de cantera en cuadrícula con grout
	for fy in range(0, alto, 48):
		for fx in range(0, ancho, 48):
			var dark := ((fx / 48) + (fy / 48)) % 2 == 0
			_rect(Vector2(fx, fy), Vector2(48, 48), Color("#CBBFA8") if dark else Color("#D8CCB4"))
			_rect(Vector2(fx, fy), Vector2(48, 2), Color("#B0A490"))
			_rect(Vector2(fx, fy), Vector2(2, 48), Color("#B0A490"))

	# Pared norte con moldura dorada
	_rect(Vector2(0, 0), Vector2(ancho, 72), Color("#EAE0CC"))
	_rect(Vector2(0, 64), Vector2(ancho, 5), Color("#C8A860"))
	_rect(Vector2(0, 69), Vector2(ancho, 3), Color("#8B7340"))

	# Zoclos laterales con moldura
	_rect(Vector2(0, 0),   Vector2(20, alto), Color("#C8BC9A"))
	_rect(Vector2(620, 0), Vector2(20, alto), Color("#C8BC9A"))
	_rect(Vector2(18, 0),  Vector2(3, alto),  Color("#B0A480"))
	_rect(Vector2(619, 0), Vector2(3, alto),  Color("#B0A480"))

	# Título DENTRO de la pared norte
	_rect(Vector2(160, 8), Vector2(320, 52), Color("#EAE0CC"))
	_label("PRESIDENCIA MUNICIPAL", Vector2(170, 10), 13, Color("#5A3A10"))
	_label("H. Ayuntamiento de San Brasa del Monte", Vector2(175, 30), 7, Color("#7A5A30"))
	_label("San Brasa del Monte, Guanajuato", Vector2(192, 44), 6, Color("#9A7A50"))

	# Ventanas pequeñas en pared norte (a los extremos)
	_ventana(Vector2(48, 10))
	_rect(Vector2(40, 8), Vector2(10, 50), Color("#C8A860"))
	_rect(Vector2(98, 8), Vector2(10, 50), Color("#C8A860"))
	_ventana(Vector2(534, 10))
	_rect(Vector2(526, 8), Vector2(10, 50), Color("#C8A860"))
	_rect(Vector2(584, 8), Vector2(10, 50), Color("#C8A860"))

	# Lámparas de techo
	_lampara(Vector2(100, 0))
	_lampara(Vector2(310, 0))
	_lampara(Vector2(520, 0))

	# Columnas decorativas desde la pared norte
	_columna(Vector2(150, 70), 370)
	_columna(Vector2(470, 70), 370)

	# Banderas debajo de la pared con espacio
	_bandera(Vector2(165, 92))
	_bandera(Vector2(210, 92))
	_bandera(Vector2(420, 92))
	_bandera(Vector2(465, 92))

	# Cuadros con marcos dorados — con espacio respirable
	_cuadro_enmarcado(Vector2(26, 100), Vector2(100, 64), Color("#C8A860"), Color("#2C4A8A"), "Constitución\nMunicipal")
	_cuadro_enmarcado(Vector2(514, 100), Vector2(100, 64), Color("#C8A860"), Color("#4A2C2C"), "Plan de\nDesarrollo\nMunicipal")
	_cuadro_enmarcado(Vector2(26, 184), Vector2(100, 56), Color("#8B6914"), Color("#1A3A1A"), "Reglamento\nInterno")
	_cuadro_enmarcado(Vector2(514, 184), Vector2(100, 56), Color("#8B6914"), Color("#1A3A1A"), "Bando\nMunicipal")

	# Mostrador de recepción — centrado con más espacio vertical
	_sombra(Vector2(160, 200), Vector2(320, 64))
	_colision(Vector2(160, 195), Vector2(320, 70))
	_mostrador(Vector2(160, 205), 320, Color("#8B6914"))
	# Monitor en el mostrador
	_rect(Vector2(400, 190), Vector2(40, 28), Color("#1A1A1A"))
	_rect(Vector2(404, 194), Vector2(32, 20), Color("#3A9FD4"))
	_rect(Vector2(414, 218), Vector2(10, 6), Color("#2A2A2A"))
	_rect(Vector2(398, 224), Vector2(44, 8), Color("#333333"))
	# Teléfono
	_rect(Vector2(200, 196), Vector2(28, 10), Color("#222222"))
	_rect(Vector2(203, 193), Vector2(22, 4), Color("#333333"))
	# Letrero recepción
	_rect(Vector2(272, 212), Vector2(136, 16), Color("#A07820"))
	_label("RECEPCIÓN", Vector2(296, 215), 9, Color("#FFE080"))

	# Panel de turnos (sobre el mostrador, no encima)
	_rect(Vector2(272, 180), Vector2(136, 22), Color("#1A1A1A"))
	_rect(Vector2(276, 183), Vector2(128, 16), Color("#222222"))
	_label("TURNO ACTUAL:  B-017", Vector2(280, 185), 7, Color("#00FF00"))

	# Zona de espera con alfombra — más abajo y más espaciosa
	_sombra(Vector2(26, 292), Vector2(260, 160))
	_alfombra(Vector2(26, 292), Vector2(260, 160), Color("#8B1A1A"))
	_colision(Vector2(26, 292), Vector2(260, 160))

	# Sillas de espera (4 + 4)
	_silla(Vector2(36, 306))
	_silla(Vector2(80, 306))
	_silla(Vector2(124, 306))
	_silla(Vector2(168, 306))
	_silla(Vector2(36, 382))
	_silla(Vector2(80, 382))
	_silla(Vector2(124, 382))
	_silla(Vector2(168, 382))
	# Mesa de centro
	_rect(Vector2(62, 348), Vector2(120, 30), Color("#6B4A20"))
	_rect(Vector2(65, 351), Vector2(114, 24), Color("#8B6A30"))
	_rect(Vector2(70, 354), Vector2(30, 16), Color("#E74C3C"))
	_label("Ley", Vector2(75, 357), 6, Color("#FFFFFF"))
	_rect(Vector2(108, 354), Vector2(30, 16), Color("#3498DB"))

	# Plantas grandes en esquinas con espacio
	_planta_grande(Vector2(22, 136))
	_planta_grande(Vector2(592, 136))
	_planta_grande(Vector2(22, 400))
	_planta_grande(Vector2(592, 400))

	# Puerta al Despacho — pared OESTE
	_puerta_interior(Vector2(-6, 208), "← Despacho del\nPresidente")

	# Puerta a Sala de Juntas — pared ESTE
	_puerta_interior(Vector2(584, 228), "Sala de →\nJuntas")

	# Puerta de Salida (sur)
	_rect(Vector2(280, 424), Vector2(80, 56), Color("#5A3020"))
	_rect(Vector2(284, 428), Vector2(34, 48), Color("#6B3A28"))
	_rect(Vector2(322, 428), Vector2(34, 48), Color("#6B3A28"))
	_rect(Vector2(315, 452), Vector2(10, 10), Color("#C8A860"))
	_label("↓  Salida", Vector2(294, 444), 10, Color("#FFD080"))
