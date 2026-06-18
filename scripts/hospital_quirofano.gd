extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	_rect(Vector2(0, 0), Vector2(ancho, alto), Color("#E8F8F0"))
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			if ((fx/40 + fy/40) % 2 == 0):
				_rect(Vector2(fx, fy), Vector2(40, 40), Color("#D5EFE5"))

	_rect(Vector2(0, 0), Vector2(ancho, 52), Color("#1A5C3A"))
	_rect(Vector2(0, 0),   Vector2(18, alto), Color("#2A7A4A"))
	_rect(Vector2(622, 0), Vector2(18, alto), Color("#2A7A4A"))

	_label("QUIRÓFANO — ACCESO RESTRINGIDO", Vector2(130, 16), 12, Color("#FFFFFF"))

	# Mesa de operaciones
	_rect(Vector2(220, 160), Vector2(200, 100), Color("#AAAAAA"))
	_rect(Vector2(224, 164), Vector2(192, 92), Color("#CCCCCC"))
	_rect(Vector2(228, 168), Vector2(184, 60), Color("#E8E8E8"))

	# Lámparas quirúrgicas
	_rect(Vector2(270, 80), Vector2(100, 24), Color("#888888"))
	_rect(Vector2(278, 56), Vector2(84, 28), Color("#FFFF80"))
	_rect(Vector2(286, 44), Vector2(68, 14), Color("#FFFFAA"))

	# Monitor de signos vitales
	_rect(Vector2(30, 120), Vector2(120, 80), Color("#111111"))
	_rect(Vector2(36, 126), Vector2(108, 48), Color("#001100"))
	_label("♥ 72bpm", Vector2(44, 134), 9, Color("#00FF00"))
	_label("SpO2: 98%", Vector2(44, 150), 8, Color("#00AAFF"))

	# Equipo médico
	_rect(Vector2(490, 120), Vector2(80, 100), Color("#DDDDDD"))
	_rect(Vector2(496, 126), Vector2(68, 60), Color("#4A90D9"))
	_label("Anestesia", Vector2(498, 192), 8, Color("#444444"))

	# Puerta de regreso
	_puerta_interior(Vector2(292, 420), "Recepción")
