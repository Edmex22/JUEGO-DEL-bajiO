extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	for fy in range(0, alto, 48):
		for fx in range(0, ancho, 48):
			_rect(Vector2(fx, fy), Vector2(48, 48), Color("#1A2A4A") if ((fx/48+fy/48)%2==0) else Color("#1E3050"))

	_rect(Vector2(0, 0), Vector2(ancho, 56), Color("#0F1E3A"))
	_rect(Vector2(0, 52), Vector2(ancho, 6), Color("#F39C12"))
	_rect(Vector2(0, 0),   Vector2(18, alto), Color("#0F1E3A"))
	_rect(Vector2(622, 0), Vector2(18, alto), Color("#0F1E3A"))

	_label("GERENCIA GENERAL", Vector2(210, 18), 13, Color("#F39C12"))

	# Escritorio del gerente
	_escritorio(Vector2(220, 160))
	_silla(Vector2(256, 220))

	# Sillas para visitantes
	_silla(Vector2(180, 320))
	_silla(Vector2(320, 320))

	# Librero con expedientes
	_rect(Vector2(30, 80), Vector2(100, 220), Color("#2A1A00"))
	for ry in range(5):
		for rx in range(3):
			_rect(Vector2(34 + rx*30, 88 + ry*40), Vector2(26, 34), [Color("#1A3A6A"), Color("#6A1A1A"), Color("#1A5A1A"), Color("#5A4A1A"), Color("#3A1A5A")][ry])

	# Cuadro en pared
	_rect(Vector2(460, 80), Vector2(120, 80), Color("#F39C12"))
	_rect(Vector2(464, 84), Vector2(112, 72), Color("#0F1E3A"))
	_label("Visión 2030:\nMunicipio\nProspero", Vector2(470, 94), 8, Color("#F39C12"))

	# Puerta de regreso
	_puerta_interior(Vector2(292, 420), "Banca Principal")
