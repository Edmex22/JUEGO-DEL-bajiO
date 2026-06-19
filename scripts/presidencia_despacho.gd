extends "res://scripts/interior_base.gd"


func _dibujar_fondo() -> void:
	# Piso de madera con vetas más detalladas
	for fy in range(0, alto, 20):
		var tono := 0.04 if (fy / 20) % 3 == 0 else (0.02 if (fy / 20) % 3 == 1 else 0.0)
		_rect(Vector2(0, fy), Vector2(ancho, 20), Color(0.38 + tono, 0.24 + tono, 0.07 + tono))
	# Vetas horizontales sutiles
	for fy in range(0, alto, 60):
		_rect(Vector2(0, fy), Vector2(ancho, 2), Color(0.28, 0.16, 0.04, 0.4))

	# Pared norte de caoba oscura con moldura
	_rect(Vector2(0, 0), Vector2(ancho, 62), Color("#3C1F0A"))
	_rect(Vector2(0, 58), Vector2(ancho, 6), Color("#C8A860"))
	# Wainscoting (friso de madera en la pared)
	_rect(Vector2(0, 62), Vector2(ancho, 30), Color("#5A3015"))
	_rect(Vector2(0, 90), Vector2(ancho, 4), Color("#3A1A05"))

	# Zoclos laterales con moldura
	_rect(Vector2(0,   0), Vector2(24, alto), Color("#4A2A0A"))
	_rect(Vector2(616, 0), Vector2(24, alto), Color("#4A2A0A"))
	_rect(Vector2(22, 0),  Vector2(4, alto),  Color("#6A3A10"))
	_rect(Vector2(614, 0), Vector2(4, alto),  Color("#6A3A10"))

	# Alfombra presidencial
	_alfombra(Vector2(140, 150), Vector2(360, 280), Color("#7A1A1A"))

	# Lámparas
	_lampara(Vector2(196, 0))
	_lampara(Vector2(396, 0))

	# Ventana grande con vista exterior simulada
	_rect(Vector2(236, 8), Vector2(168, 52), Color("#1A3A5A"))
	_rect(Vector2(240, 12), Vector2(72, 44), Color("#5A9FBF"))
	_rect(Vector2(328, 12), Vector2(72, 44), Color("#5A9FBF"))
	_rect(Vector2(312, 8),  Vector2(8,  52), Color("#C8A870"))
	# Vista de cielo
	_rect(Vector2(241, 13), Vector2(70, 20), Color("#87CEEB"))
	_rect(Vector2(329, 13), Vector2(70, 20), Color("#87CEEB"))
	# Cortinas
	_rect(Vector2(228, 6), Vector2(12, 56), Color("#722222"))
	_rect(Vector2(404, 6), Vector2(12, 56), Color("#722222"))

	# Banderas
	_bandera(Vector2(544, 68))
	_bandera(Vector2(590, 68))

	# Cuadros en la pared norte
	_cuadro_enmarcado(Vector2(26, 68), Vector2(80, 60), Color("#C8A860"), Color("#2C3E70"), "Escudo\nMunicipal")
	_cuadro_enmarcado(Vector2(534, 68), Vector2(60, 60), Color("#C8A860"), Color("#4A2020"), "Himno\nNacional")
	_cuadro_enmarcado(Vector2(28, 152), Vector2(76, 50), Color("#8B6914"), Color("#1A2A1A"), "Plan de\nGobierno\n2024-2027")

	# Estante de libros lateral
	_sombra(Vector2(28, 200), Vector2(80, 148))
	_estante_libros(Vector2(28, 200), 4)
	_colision(Vector2(28, 200), Vector2(80, 148))

	# Credenza (mueble bajo detrás del escritorio)
	_sombra(Vector2(186, 116), Vector2(268, 50))
	_rect(Vector2(180, 116), Vector2(280, 44), Color("#3A1A05"))
	_rect(Vector2(184, 120), Vector2(84, 36), Color("#4A2A10"))
	_rect(Vector2(272, 120), Vector2(84, 36), Color("#4A2A10"))
	_rect(Vector2(360, 120), Vector2(96, 36), Color("#4A2A10"))
	# Adornos en credenza
	_rect(Vector2(194, 112), Vector2(24, 10), Color("#C8A860"))  # trofeo
	_rect(Vector2(274, 112), Vector2(16, 10), Color("#C8A860"))
	_label("Alcalde 2024", Vector2(530, 122), 7, Color("#C8A860"))
	_colision(Vector2(186, 116), Vector2(268, 50))

	# Escritorio presidencial más detallado
	_sombra(Vector2(196, 176), Vector2(248, 90))
	_rect(Vector2(196, 188), Vector2(248, 76), Color("#3A1A05"))
	_rect(Vector2(196, 176), Vector2(248, 14), Color("#5A2A10"))
	_rect(Vector2(196, 174), Vector2(248, 4), Color("#C8A860"))
	# Superficie con papeles
	_rect(Vector2(204, 192), Vector2(60, 40), Color("#FFFDF0"))
	_rect(Vector2(268, 196), Vector2(44, 32), Color("#F0EFE8"))
	_rect(Vector2(316, 196), Vector2(36, 28), Color("#E8F4FD"))
	# Teléfono
	_rect(Vector2(365, 190), Vector2(28, 12), Color("#1A1A1A"))
	_rect(Vector2(368, 188), Vector2(22, 4), Color("#333333"))
	# Laptop
	_rect(Vector2(358, 176), Vector2(50, 34), Color("#2A2A2A"))
	_rect(Vector2(362, 180), Vector2(42, 26), Color("#2A6AAA"))
	# Portanombre dorado
	_rect(Vector2(208, 228), Vector2(80, 8), Color("#C8A860"))
	_label("Presidente Municipal", Vector2(196, 232), 6, Color("#C8A860"))
	_colision(Vector2(196, 176), Vector2(248, 90))

	# Silla presidencial grande
	_rect(Vector2(284, 258), Vector2(72, 52), Color("#5A1010"))
	_rect(Vector2(288, 262), Vector2(64, 44), Color("#7A1A1A"))
	_rect(Vector2(284, 236), Vector2(72, 24), Color("#5A1010"))
	_rect(Vector2(286, 238), Vector2(68, 20), Color("#6A1A1A"))

	# Sillas para visitas
	_silla(Vector2(212, 310))
	_silla(Vector2(390, 310))

	# Plantas decorativas
	_planta_grande(Vector2(534, 200))
	_maceta(Vector2(534, 360))

	# Puerta de regreso a Recepción
	_puerta_interior(Vector2(292, 420), "← Recepción")
