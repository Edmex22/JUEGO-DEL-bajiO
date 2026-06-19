extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso quirúrgico impecable con grout
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			_rect(Vector2(fx, fy), Vector2(40, 40), Color("#E8F8F0"))
			if (fx / 40 + fy / 40) % 2 == 0:
				_rect(Vector2(fx, fy), Vector2(40, 40), Color("#D5EFE5"))
			_rect(Vector2(fx, fy), Vector2(40, 2), Color("#C0DDD0"))
			_rect(Vector2(fx, fy), Vector2(2, 40), Color("#C0DDD0"))

	# Pared norte quirúrgica con franja
	_rect(Vector2(0, 0), Vector2(ancho, 60), Color("#0D4A2A"))
	_rect(Vector2(0, 56), Vector2(ancho, 6), Color("#00AA55"))
	_rect(Vector2(0, 60), Vector2(ancho, 20), Color("#145A34"))
	_rect(Vector2(0, 78), Vector2(ancho, 4), Color("#0A3A20"))

	# Zoclos
	_rect(Vector2(0, 0),   Vector2(22, alto), Color("#145A34"))
	_rect(Vector2(618, 0), Vector2(22, alto), Color("#145A34"))
	_rect(Vector2(20, 0),  Vector2(4,  alto), Color("#00AA55"))
	_rect(Vector2(616, 0), Vector2(4,  alto), Color("#00AA55"))

	# Letrero de acceso restringido
	_rect(Vector2(172, 8), Vector2(296, 36), Color("#0A3A20"))
	_rect(Vector2(176, 12), Vector2(288, 28), Color("#1A5A3A"))
	_label("✚  QUIRÓFANO  ✚", Vector2(228, 14), 12, Color("#FFFFFF"))
	_label("ACCESO RESTRINGIDO — PERSONAL AUTORIZADO", Vector2(148, 34), 8, Color("#00CC66"))

	# Lámparas quirúrgicas especiales (grandes, centradas)
	_lampara_quirurgica(Vector2(240, 0))
	_lampara_quirurgica(Vector2(360, 0))

	# Mesa de operaciones detallada
	_rect(Vector2(210, 162), Vector2(220, 108), Color("#8A8A8A"))
	_rect(Vector2(214, 166), Vector2(212, 100), Color("#A0A0A0"))
	# Superficie
	_rect(Vector2(218, 170), Vector2(204, 64), Color("#E8E8E8"))
	# Colchón quirúrgico
	_rect(Vector2(222, 172), Vector2(196, 60), Color("#DDEEDD"))
	# Paciente (silueta)
	_rect(Vector2(238, 176), Vector2(164, 16), Color("#F0E0D0"))
	_rect(Vector2(254, 190), Vector2(40, 36), Color("#F0E0D0"))
	# Sábana estéril
	_rect(Vector2(222, 186), Vector2(196, 46), Color("#E8F8F0"))
	# Patas de la mesa
	_rect(Vector2(218, 270), Vector2(12, 24), Color("#888888"))
	_rect(Vector2(410, 270), Vector2(12, 24), Color("#888888"))
	_rect(Vector2(214, 288), Vector2(20, 6), Color("#666666"))
	_rect(Vector2(406, 288), Vector2(20, 6), Color("#666666"))

	# Monitor de signos vitales grande
	_rect(Vector2(24, 100), Vector2(144, 100), Color("#111111"))
	_rect(Vector2(28, 104), Vector2(136, 60), Color("#001A00"))
	# Líneas del monitor
	for lx in range(0, 120, 20):
		var h1 := 14 if lx % 40 == 0 else 8
		_rect(Vector2(32 + lx, 124), Vector2(2, h1), Color("#00FF00"))
	_rect(Vector2(28, 124), Vector2(136, 2), Color("#003300"))
	_label("♥ 72 bpm", Vector2(36, 108), 9, Color("#00FF00"))
	_label("SpO2: 98%", Vector2(36, 120), 8, Color("#00AAFF"))
	_label("TA: 120/80", Vector2(36, 132), 8, Color("#FF6600"))
	_label("T°: 36.5°C", Vector2(36, 144), 8, Color("#FFCC00"))
	# Base del monitor
	_rect(Vector2(60, 200), Vector2(72, 12), Color("#1A1A1A"))
	_rect(Vector2(80, 210), Vector2(32, 30), Color("#222222"))

	# Equipo de anestesia detallado
	_rect(Vector2(472, 100), Vector2(100, 140), Color("#CCCCCC"))
	_rect(Vector2(476, 104), Vector2(92, 52), Color("#4A90D9"))
	_rect(Vector2(480, 108), Vector2(84, 44), Color("#2A6AB9"))
	_label("Anestesia\nVersatrack", Vector2(492, 116), 8, Color("#FFFFFF"))
	_label("ACTIVO", Vector2(498, 136), 7, Color("#00FF00"))
	_rect(Vector2(476, 160), Vector2(92, 20), Color("#BBBBBB"))
	for kx in range(4):
		_rect(Vector2(480 + kx * 22, 163), Vector2(16, 14), Color("#DDDDDD"))
	# Tubos y cables
	_rect(Vector2(560, 240), Vector2(4, 60), Color("#444444"))
	_rect(Vector2(440, 168), Vector2(34, 4), Color("#88CCEE"))
	_rect(Vector2(430, 170), Vector2(12, 60), Color("#88CCEE"))

	# Mesa de instrumental quirúrgico
	_rect(Vector2(472, 260), Vector2(100, 60), Color("#C0C0C0"))
	_rect(Vector2(476, 264), Vector2(92, 52), Color("#D0D0D0"))
	# Instrumentos
	for ix in range(6):
		_rect(Vector2(480 + ix * 14, 268), Vector2(6, 40), Color("#A0A0A0"))
	_rect(Vector2(476, 264), Vector2(92, 6), Color("#B0B0B0"))

	# Cubeta de esterilización
	_rect(Vector2(24, 230), Vector2(56, 48), Color("#888888"))
	_rect(Vector2(28, 234), Vector2(48, 40), Color("#999999"))
	_label("Esteril.", Vector2(30, 268), 7, Color("#444444"))

	# Carrito de medicamentos
	_rect(Vector2(148, 260), Vector2(48, 64), Color("#EEEEEE"))
	_rect(Vector2(152, 264), Vector2(40, 16), Color("#3498DB"))
	_rect(Vector2(152, 284), Vector2(40, 16), Color("#27AE60"))
	_rect(Vector2(152, 304), Vector2(40, 16), Color("#E74C3C"))
	_rect(Vector2(155, 268), Vector2(6, 8), Color("#2A6AB9"))
	_rect(Vector2(180, 268), Vector2(6, 8), Color("#2A6AB9"))

	# Cuadros médicos
	_cuadro_enmarcado(Vector2(24, 68), Vector2(80, 30), Color("#00AA55"), Color("#0A2A18"), "Protocolo\nQx Estéril")
	_cuadro_enmarcado(Vector2(536, 68), Vector2(80, 30), Color("#00AA55"), Color("#0A2A18"), "Emergencia:\nExt. 911")

	# Puerta de regreso
	_puerta_interior(Vector2(292, 420), "← Recepción Hospital")


func _lampara_quirurgica(pos: Vector2) -> void:
	# Brazo
	_rect(pos + Vector2(18, 0), Vector2(8, 20), Color("#555555"))
	# Cuerpo de la lámpara
	_rect(pos, Vector2(44, 22), Color("#CCCCCC"))
	_rect(pos + Vector2(2, 2), Vector2(40, 18), Color("#DDDDDD"))
	# Luz intensa
	_rect(pos + Vector2(4, 6), Vector2(36, 10), Color("#FFFFC0"))
	# Halo de luz grande en el piso
	_rect(pos + Vector2(-30, 80), Vector2(104, 40), Color(1.0, 1.0, 0.9, 0.12))
