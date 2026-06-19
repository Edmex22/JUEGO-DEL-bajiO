extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso corporativo oscuro con grout
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			var c := Color("#282828") if ((fx/40 + fy/40) % 2 == 0) else Color("#202020")
			_rect(Vector2(fx, fy), Vector2(40, 40), c)
			_rect(Vector2(fx, fy), Vector2(40, 2), Color("#181818"))
			_rect(Vector2(fx, fy), Vector2(2, 40), Color("#181818"))

	# Pared norte SAT
	_rect(Vector2(0, 0), Vector2(ancho, 64), Color("#181818"))
	_rect(Vector2(0, 60), Vector2(ancho, 6), Color("#E74C3C"))
	_rect(Vector2(0, 64), Vector2(ancho, 3), Color("#C0392B"))

	# Zoclos con acento rojo
	_rect(Vector2(0, 0),   Vector2(22, alto), Color("#181818"))
	_rect(Vector2(618, 0), Vector2(22, alto), Color("#181818"))
	_rect(Vector2(20, 0),  Vector2(4, alto),  Color("#E74C3C"))
	_rect(Vector2(616, 0), Vector2(4, alto),  Color("#E74C3C"))

	# Logo SAT grande
	_rect(Vector2(260, 8), Vector2(120, 44), Color("#E74C3C"))
	_rect(Vector2(264, 12), Vector2(112, 36), Color("#C0392B"))
	_label("SAT", Vector2(293, 18), 18, Color("#FFFFFF"))

	# Lemas
	_label("Servicio de Administración Tributaria", Vector2(120, 34), 10, Color("#E74C3C"))
	_label("\"Tu cumplimiento es el futuro de México\"", Vector2(130, 48), 8, Color("#888888"))

	# Lámparas de oficina (fluorescentes)
	for lx in [80, 220, 320, 420, 560]:
		_lampara(Vector2(lx, 0))

	# Tablero de turnos digital
	_rect(Vector2(200, 66), Vector2(240, 40), Color("#111111"))
	_rect(Vector2(204, 70), Vector2(232, 32), Color("#0A0A0A"))
	_rect(Vector2(208, 74), Vector2(100, 24), Color("#111111"))
	_label("TURNO:", Vector2(212, 76), 8, Color("#888888"))
	_label("A-042", Vector2(212, 86), 10, Color("#E74C3C"))
	_rect(Vector2(314, 74), Vector2(114, 24), Color("#111111"))
	_label("VENTANILLA:", Vector2(318, 76), 7, Color("#888888"))
	_label("03", Vector2(360, 86), 10, Color("#E74C3C"))

	# Máquina de turnos
	_rect(Vector2(22, 100), Vector2(52, 80), Color("#2A2A2A"))
	_rect(Vector2(26, 104), Vector2(44, 28), Color("#E74C3C"))
	_label("TURNO", Vector2(32, 110), 8, Color("#FFFFFF"))
	_rect(Vector2(26, 138), Vector2(44, 14), Color("#1A1A1A"))
	_label("Toma tu\nturno aquí", Vector2(25, 158), 7, Color("#888888"))

	# Ventanillas de atención (4 ventanillas)
	for i in range(4):
		_ventanilla(Vector2(30 + i * 150, 100), i + 1)

	# Separadores de cola
	for bx in range(6):
		_rect(Vector2(22 + bx * 100, 220), Vector2(6, 50), Color("#E74C3C"))
		if bx < 5:
			var y_c := 220 if bx % 2 == 0 else 264
			_rect(Vector2(28 + bx * 100, y_c), Vector2(94, 4), Color("#E74C3C"))

	# Sillas de espera
	_alfombra(Vector2(22, 238), Vector2(596, 110), Color("#1A1A1A"))
	for sx in range(7):
		_silla(Vector2(28 + sx * 84, 250))

	# Archiveros laterales
	for i in range(3):
		_rect(Vector2(560, 100 + i * 52), Vector2(56, 50), Color("#2A2A2A"))
		_rect(Vector2(564, 104 + i * 52), Vector2(48, 18), Color("#333333"))
		_rect(Vector2(564, 126 + i * 52), Vector2(48, 18), Color("#333333"))
		_rect(Vector2(590, 112 + i * 52), Vector2(8, 4), Color("#E74C3C"))
		_rect(Vector2(590, 134 + i * 52), Vector2(8, 4), Color("#E74C3C"))

	# Cuadros informativos
	_cuadro_enmarcado(Vector2(24, 68), Vector2(80, 60), Color("#E74C3C"), Color("#1A1A1A"), "RFC\nDeclaración\nAnual")
	_cuadro_enmarcado(Vector2(536, 68), Vector2(80, 60), Color("#E74C3C"), Color("#1A1A1A"), "IVA\nISR\nIMSS")

	# Puerta a archivo tributario
	_puerta_interior(Vector2(540, 360), "→ Archivo")

	# Puerta de salida
	_rect(Vector2(276, 424), Vector2(88, 56), Color("#1A1A1A"))
	_rect(Vector2(280, 428), Vector2(36, 48), Color("#2A2A2A"))
	_rect(Vector2(320, 428), Vector2(36, 48), Color("#2A2A2A"))
	_rect(Vector2(312, 450), Vector2(12, 12), Color("#E74C3C"))
	_label("↓  Salida", Vector2(293, 444), 10, Color("#E74C3C"))


func _ventanilla(pos: Vector2, num: int) -> void:
	# Sombra
	_rect(pos + Vector2(3, 3), Vector2(130, 96), Color(0, 0, 0, 0.3))
	# Estructura
	_rect(pos, Vector2(128, 94), Color("#2A2A2A"))
	_rect(pos + Vector2(3, 3), Vector2(122, 60), Color("#1A1A1A"))
	# Vidrio con reflejo
	_rect(pos + Vector2(3, 3), Vector2(122, 48), Color("#0A1A2A"))
	_rect(pos + Vector2(5, 5), Vector2(30, 20), Color("#0F2030"))
	# Mostrador
	_rect(pos + Vector2(0, 66), Vector2(128, 18), Color("#333333"))
	_rect(pos + Vector2(0, 62), Vector2(128, 6), Color("#E74C3C"))
	# Número y estado
	_label("VENTANILLA " + str(num), pos + Vector2(16, 68), 8, Color("#E74C3C"))
	_rect(pos + Vector2(86, 6), Vector2(36, 14), Color("#1A3A1A"))
	_label("ABIERTA", pos + Vector2(88, 8), 6, Color("#00CC00"))
	# Separador de vidrio
	_rect(pos + Vector2(60, 3), Vector2(4, 58), Color("#333333"))
