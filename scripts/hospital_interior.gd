extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso clínico con líneas de grout
	for fy in range(0, alto, 40):
		for fx in range(0, ancho, 40):
			_rect(Vector2(fx, fy), Vector2(40, 40), Color("#F0F4F8"))
			_rect(Vector2(fx, fy), Vector2(40, 2), Color("#D8DEE4"))
			_rect(Vector2(fx, fy), Vector2(2, 40), Color("#D8DEE4"))

	# Líneas de orientación en el piso
	_rect(Vector2(0, 195), Vector2(ancho, 8), Color("#3498DB"))
	_rect(Vector2(0, 275), Vector2(ancho, 8), Color("#E74C3C"))
	_label("→  URGENCIAS", Vector2(20, 196), 7, Color("#FFFFFF"))
	_label("→  CONSULTAS", Vector2(20, 276), 7, Color("#FFFFFF"))

	# Pared norte hospitalaria
	_rect(Vector2(0, 0), Vector2(ancho, 60), Color("#FFFFFF"))
	_rect(Vector2(0, 56), Vector2(ancho, 6), Color("#BDC3C7"))
	_rect(Vector2(0, 58), Vector2(ancho, 4), Color("#3498DB"))

	# Zoclos
	_rect(Vector2(0, 0),   Vector2(20, alto), Color("#E8ECF0"))
	_rect(Vector2(620, 0), Vector2(20, alto), Color("#E8ECF0"))
	_rect(Vector2(18, 0),  Vector2(4,  alto), Color("#BDC3C7"))
	_rect(Vector2(618, 0), Vector2(4,  alto), Color("#BDC3C7"))

	# Cruz roja con fondo
	_rect(Vector2(276, 6), Vector2(88, 26), Color("#FFFFFF"))
	_rect(Vector2(288, 8), Vector2(64, 22), Color("#E74C3C"))
	_rect(Vector2(302, 2), Vector2(36, 34), Color("#E74C3C"))
	_rect(Vector2(308, 8), Vector2(24, 22), Color("#FFFFFF"))
	_rect(Vector2(302, 14), Vector2(36, 10), Color("#FFFFFF"))

	# Letrero
	_label("HOSPITAL GENERAL", Vector2(178, 40), 14, Color("#2C3E50"))

	# Lámparas de techo (quirúrgicas)
	_lampara(Vector2(96, 0))
	_lampara(Vector2(220, 0))
	_lampara(Vector2(420, 0))
	_lampara(Vector2(544, 0))

	# Dispensadores de gel en entrada
	_rect(Vector2(22, 60), Vector2(18, 32), Color("#3498DB"))
	_rect(Vector2(25, 56), Vector2(12, 6), Color("#2980B9"))
	_label("GEL", Vector2(24, 80), 6, Color("#FFFFFF"))
	_rect(Vector2(600, 60), Vector2(18, 32), Color("#3498DB"))
	_rect(Vector2(603, 56), Vector2(12, 6), Color("#2980B9"))
	_label("GEL", Vector2(602, 80), 6, Color("#FFFFFF"))

	# Mostrador de admisiones detallado
	_mostrador(Vector2(130, 92), 380, Color("#95A5A6"))
	_label("ADMISIONES / RECEPCIÓN", Vector2(225, 100), 10, Color("#2C3E50"))
	# Monitor en admisiones
	_rect(Vector2(148, 76), Vector2(40, 28), Color("#1A1A1A"))
	_rect(Vector2(152, 80), Vector2(32, 20), Color("#3A9FD4"))
	_rect(Vector2(164, 104), Vector2(10, 6), Color("#2A2A2A"))
	# Carpetas
	_rect(Vector2(440, 78), Vector2(28, 16), Color("#E74C3C"))
	_rect(Vector2(470, 78), Vector2(28, 16), Color("#3498DB"))
	_rect(Vector2(500, 78), Vector2(28, 16), Color("#27AE60"))

	# Zona de espera — sillas en filas
	_alfombra(Vector2(22, 205), Vector2(390, 140), Color("#2C3E50"))
	for sx in range(5):
		_silla(Vector2(30 + sx * 70, 218))
	for sx in range(5):
		_silla(Vector2(30 + sx * 70, 300))
	# Mesita con revistas
	_rect(Vector2(200, 262), Vector2(50, 32), Color("#7F8C8D"))
	_rect(Vector2(203, 264), Vector2(44, 26), Color("#95A5A6"))
	_rect(Vector2(206, 266), Vector2(18, 18), Color("#E74C3C"))
	_rect(Vector2(226, 266), Vector2(18, 18), Color("#3498DB"))

	# Cuadros informativos en pared
	_cuadro_enmarcado(Vector2(24, 70), Vector2(72, 44), Color("#3498DB"), Color("#EBF5FB"), "Horario\nAtención\n8–20 hrs")
	_cuadro_enmarcado(Vector2(544, 70), Vector2(72, 44), Color("#E74C3C"), Color("#FDEDEC"), "Urgencias\n24 hrs")

	# Camillas lado derecho
	_rect(Vector2(468, 110), Vector2(130, 8), Color("#BDC3C7"))
	_cama_hospital(Vector2(472, 118))
	_rect(Vector2(472, 118), Vector2(80, 6), Color("#3498DB"))
	_cama_hospital(Vector2(472, 186))

	# Área de consultorios (partición)
	_rect(Vector2(464, 100), Vector2(6, 250), Color("#BDC3C7"))
	_label("URGENCIAS", Vector2(476, 108), 8, Color("#E74C3C"))
	_label("CONSULTA\nGENERAL", Vector2(476, 188), 8, Color("#1A5276"))

	# Equipo médico
	_rect(Vector2(582, 120), Vector2(30, 60), Color("#7F8C8D"))
	_rect(Vector2(585, 124), Vector2(24, 20), Color("#2C3E50"))
	_label("ECG", Vector2(586, 128), 7, Color("#00FF00"))
	_rect(Vector2(582, 190), Vector2(30, 40), Color("#95A5A6"))

	# Puerta a quirófano
	_puerta_interior(Vector2(514, 360), "→ Quirófano")

	# Puerta de salida
	_rect(Vector2(276, 424), Vector2(88, 56), Color("#2980B9"))
	_rect(Vector2(280, 428), Vector2(36, 48), Color("#3498DB"))
	_rect(Vector2(320, 428), Vector2(36, 48), Color("#3498DB"))
	_rect(Vector2(312, 450), Vector2(12, 12), Color("#FFFFFF"))
	_label("↓  Salida", Vector2(292, 444), 10, Color("#FFFFFF"))
