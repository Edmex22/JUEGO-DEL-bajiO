extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso oscuro corporativo
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			var c := Color("#2A2A2A") if ((fx/40 + fy/40) % 2 == 0) else Color("#222222")
			_rect(Vector2(fx, fy), Vector2(40, 40), c)

	# Pared norte roja SAT
	_rect(Vector2(0, 0), Vector2(ancho, 60), Color("#1A1A1A"))
	_rect(Vector2(0, 55), Vector2(ancho, 8), Color("#E74C3C"))

	# Zoclos
	_rect(Vector2(0, 0),   Vector2(18, alto), Color("#1A1A1A"))
	_rect(Vector2(622, 0), Vector2(18, alto), Color("#1A1A1A"))

	# Letrero SAT
	_label("SAT — Servicio de Administración Tributaria", Vector2(70, 18), 12, Color("#E74C3C"))
	_label("Cumple con tus obligaciones fiscales.", Vector2(168, 36), 9, Color("#AAAAAA"))

	# Ventanillas de atención (3 ventanillas)
	for i in range(3):
		_ventanilla(Vector2(60 + i * 180, 90), "Ventanilla " + str(i + 1))

	# Sillas de espera con número de turno
	for sx in range(6):
		_silla(Vector2(30 + sx * 90, 240))
	_rect(Vector2(20, 220), Vector2(580, 8), Color("#E74C3C"))

	# Tablero de turnos
	_rect(Vector2(240, 60), Vector2(160, 28), Color("#111111"))
	_rect(Vector2(244, 64), Vector2(152, 20), Color("#E74C3C"))
	_label("TURNO: A-042", Vector2(258, 68), 9, Color("#FFFFFF"))

	# Máquina de turnos
	_rect(Vector2(20, 360), Vector2(48, 60), Color("#333333"))
	_rect(Vector2(26, 366), Vector2(36, 16), Color("#E74C3C"))
	_label("Toma tu\nturno", Vector2(22, 385), 7, Color("#AAAAAA"))

	# Puerta a archivo tributario
	_puerta_interior(Vector2(544, 200), "Archivo")

	# Puerta de salida
	_rect(Vector2(284, 432), Vector2(72, 48), Color("#1A1A1A"))
	_label("Salida", Vector2(300, 446), 10, Color("#E74C3C"))


func _ventanilla(pos: Vector2, nombre: String) -> void:
	_rect(pos, Vector2(120, 80), Color("#333333"))
	_rect(pos + Vector2(4, 4), Vector2(112, 52), Color("#1A1A1A"))
	# Vidrio de la ventanilla
	_rect(pos + Vector2(4, 4), Vector2(112, 40), Color("#1E3A5F"))
	# Mostrador
	_rect(pos + Vector2(0, 62), Vector2(120, 16), Color("#444444"))
	_label(nombre, pos + Vector2(20, 68), 8, Color("#E74C3C"))
