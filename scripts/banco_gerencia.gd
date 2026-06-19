extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso de madera fina oscura
	for fy in range(0, alto, 20):
		var tono := 0.03 if (fy / 20) % 3 == 0 else 0.0
		_rect(Vector2(0, fy), Vector2(ancho, 20), Color(0.20 + tono, 0.12 + tono, 0.04 + tono))
	for fy in range(0, alto, 60):
		_rect(Vector2(0, fy), Vector2(ancho, 2), Color(0.12, 0.07, 0.02, 0.4))

	# Pared norte
	_rect(Vector2(0, 0), Vector2(ancho, 64), Color("#0F1E3A"))
	_rect(Vector2(0, 60), Vector2(ancho, 6), Color("#F39C12"))
	_rect(Vector2(0, 64), Vector2(ancho, 26), Color("#152840"))
	_rect(Vector2(0, 88), Vector2(ancho, 4), Color("#0A1428"))

	# Zoclos con moldura dorada
	_rect(Vector2(0, 0),   Vector2(22, alto), Color("#0F1E3A"))
	_rect(Vector2(618, 0), Vector2(22, alto), Color("#0F1E3A"))
	_rect(Vector2(20, 0),  Vector2(4, alto),  Color("#F39C12"))
	_rect(Vector2(616, 0), Vector2(4, alto),  Color("#F39C12"))

	# Alfombra ejecutiva
	_alfombra(Vector2(140, 120), Vector2(360, 280), Color("#0A1E3A"))

	# Lámparas
	_lampara(Vector2(196, 0))
	_lampara(Vector2(396, 0))

	# Título en pared
	_label("GERENCIA GENERAL", Vector2(208, 18), 14, Color("#F39C12"))
	_label("Banco Municipal de San Brasa", Vector2(200, 38), 9, Color("#AACCFF"))

	# Ventana lateral con vista
	_rect(Vector2(24, 80), Vector2(100, 130), Color("#1A3A6A"))
	_rect(Vector2(28, 84), Vector2(44, 122), Color("#5A9FBF"))
	_rect(Vector2(76, 84), Vector2(44, 122), Color("#5A9FBF"))
	_rect(Vector2(70, 80), Vector2(8, 130), Color("#C8A870"))
	_rect(Vector2(28, 84), Vector2(44, 40), Color("#87CEEB"))
	_rect(Vector2(76, 84), Vector2(44, 40), Color("#87CEEB"))
	# Cortinas doradas
	_rect(Vector2(16, 76), Vector2(12, 140), Color("#C8A860"))
	_rect(Vector2(124, 76), Vector2(12, 140), Color("#C8A860"))

	# Estante de libros grande
	_estante_libros(Vector2(148, 92), 5)

	# Credenza / mueble bajo detrás del escritorio
	_rect(Vector2(186, 116), Vector2(268, 48), Color("#0A1428"))
	_rect(Vector2(190, 120), Vector2(80, 40), Color("#152840"))
	_rect(Vector2(274, 120), Vector2(80, 40), Color("#152840"))
	_rect(Vector2(358, 120), Vector2(92, 40), Color("#152840"))
	# Trofeos y reconocimientos
	_rect(Vector2(198, 108), Vector2(20, 12), Color("#F39C12"))
	_rect(Vector2(204, 104), Vector2(8, 6), Color("#C8A860"))
	_rect(Vector2(282, 108), Vector2(16, 12), Color("#C0C0C0"))
	_rect(Vector2(288, 104), Vector2(6, 6), Color("#A0A0A0"))

	# Cuadros en pared
	_cuadro_enmarcado(Vector2(250, 68), Vector2(140, 80), Color("#F39C12"), Color("#0A1428"), "Visión 2030:\nMunicipio\nProspero y\nSustentable")
	_cuadro_enmarcado(Vector2(536, 80), Vector2(80, 60), Color("#F39C12"), Color("#0A1428"), "Premio\nExcelencia\nBancaria\n2023")

	# Escritorio gerencial grande y detallado
	_rect(Vector2(196, 196), Vector2(248, 84), Color("#0A1428"))
	_rect(Vector2(196, 184), Vector2(248, 14), Color("#1A3A6A"))
	_rect(Vector2(196, 182), Vector2(248, 4), Color("#F39C12"))
	# Superficie
	_rect(Vector2(204, 200), Vector2(64, 44), Color("#FFFDF0"))
	_rect(Vector2(272, 204), Vector2(48, 36), Color("#F0EFE8"))
	# Laptop
	_rect(Vector2(328, 186), Vector2(52, 38), Color("#1A1A1A"))
	_rect(Vector2(332, 190), Vector2(44, 30), Color("#1A3A6A"))
	_label("$ BANCO", Vector2(336, 200), 8, Color("#F39C12"))
	# Teléfono ejecutivo
	_rect(Vector2(375, 200), Vector2(30, 14), Color("#1A1A1A"))
	_rect(Vector2(378, 198), Vector2(24, 4), Color("#333333"))
	# Portanombre
	_rect(Vector2(208, 238), Vector2(96, 10), Color("#F39C12"))
	_label("Lic. Ignacio Treviño — Gerente General", Vector2(196, 248), 6, Color("#F39C12"))

	# Silla gerencial
	_rect(Vector2(280, 274), Vector2(80, 56), Color("#0A1428"))
	_rect(Vector2(284, 278), Vector2(72, 48), Color("#1A2A5A"))
	_rect(Vector2(280, 250), Vector2(80, 26), Color("#0A1428"))
	_rect(Vector2(284, 252), Vector2(72, 22), Color("#1A2A5A"))

	# Sillas para visitantes
	_silla(Vector2(196, 320))
	_silla(Vector2(396, 320))

	# Planta decorativa
	_planta_grande(Vector2(540, 200))

	# Puerta de regreso
	_puerta_interior(Vector2(292, 420), "← Banca Principal")
