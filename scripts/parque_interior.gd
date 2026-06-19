extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Pasto con variación de tono
	for fy in range(0, alto, 28):
		for fx in range(0, ancho, 28):
			var idx := (fx / 28 + fy / 28) % 3
			var c := [Color("#5EAA40"), Color("#68B848"), Color("#62B244")][idx]
			_rect(Vector2(fx, fy), Vector2(28, 28), c)

	# Bardas con diseño
	_rect(Vector2(0, 0),   Vector2(ancho, 14), Color("#3A2A10"))
	_rect(Vector2(0, 454), Vector2(ancho, 14), Color("#3A2A10"))
	_rect(Vector2(0, 0),   Vector2(14, alto),  Color("#3A2A10"))
	_rect(Vector2(626, 0), Vector2(14, alto),  Color("#3A2A10"))
	# Barrotes de reja
	for bx in range(0, ancho, 18):
		_rect(Vector2(bx + 3, 0), Vector2(6, 14), Color("#5A4020"))
	for bx in range(0, ancho, 18):
		_rect(Vector2(bx + 3, 454), Vector2(6, 14), Color("#5A4020"))

	# Letrero de entrada
	_rect(Vector2(224, 2), Vector2(192, 22), Color("#1A3A0A"))
	_rect(Vector2(228, 6), Vector2(184, 14), Color("#2D5A14"))
	_label("✦  PARQUE CENTRAL  ✦", Vector2(238, 8), 9, Color("#90EE60"))

	# Caminos de grava hacia la fuente
	_rect(Vector2(290, 14), Vector2(60, 180), Color("#C8B890"))
	_rect(Vector2(290, 284), Vector2(60, 160), Color("#C8B890"))
	_rect(Vector2(14, 192), Vector2(278, 60), Color("#C8B890"))
	_rect(Vector2(348, 192), Vector2(278, 60), Color("#C8B890"))
	# Bordes del camino
	for i in range(0, 178, 20):
		_rect(Vector2(290, 14 + i), Vector2(60, 2), Color("#B0A070"))
	for i in range(0, 276, 20):
		_rect(Vector2(14 + i, 192), Vector2(2, 60), Color("#B0A070"))

	# Fuente central más detallada
	_rect(Vector2(258, 164), Vector2(124, 124), Color("#1A5A8A"))
	_rect(Vector2(264, 170), Vector2(112, 112), Color("#2980B9"))
	# Borde de la fuente
	_rect(Vector2(260, 166), Vector2(120, 10), Color("#3498DB"))
	_rect(Vector2(260, 278), Vector2(120, 10), Color("#3498DB"))
	_rect(Vector2(260, 166), Vector2(10, 122), Color("#3498DB"))
	_rect(Vector2(370, 166), Vector2(10, 122), Color("#3498DB"))
	# Agua
	_rect(Vector2(270, 176), Vector2(100, 100), Color("#3498DB"))
	_rect(Vector2(274, 180), Vector2(92,  92), Color("#5DADE2"))
	# Surtidor central
	_rect(Vector2(312, 200), Vector2(16, 52), Color("#1A6A9A"))
	_rect(Vector2(308, 196), Vector2(24, 8), Color("#5DADE2"))
	# Chorro de agua (simulado)
	_rect(Vector2(318, 162), Vector2(4, 36), Color("#87CEEB"))
	_rect(Vector2(314, 168), Vector2(12, 6), Color("#AED6F1"))
	_rect(Vector2(310, 174), Vector2(20, 4), Color("#D6EAF8"))
	# Monedas en el fondo
	for cx in range(4):
		for cy in range(3):
			_rect(Vector2(278 + cx * 20, 220 + cy * 16), Vector2(10, 6), Color("#F39C12"))

	# Bancas alrededor de la fuente (más detalladas)
	_banca_detallada(Vector2(218, 180))
	_banca_detallada(Vector2(390, 180))
	_banca_detallada(Vector2(218, 298))
	_banca_detallada(Vector2(390, 298))

	# Árboles grandes en esquinas y bordes
	_arbol_grande(Vector2(22, 22))
	_arbol_grande(Vector2(548, 22))
	_arbol_grande(Vector2(22, 360))
	_arbol_grande(Vector2(548, 360))
	_arbol_grande(Vector2(170, 50))
	_arbol_grande(Vector2(420, 50))
	_arbol_grande(Vector2(170, 370))
	_arbol_grande(Vector2(420, 370))

	# Arbustos
	_arbusto(Vector2(22, 200))
	_arbusto(Vector2(22, 260))
	_arbusto(Vector2(600, 200))
	_arbusto(Vector2(600, 260))

	# Kiosco de comida más detallado
	_rect(Vector2(22, 22), Vector2(3, 3), Color("#5A3A1A"))  # base ya cubierta por árbol
	_kiosco(Vector2(548, 280))

	# Zona de juegos infantiles
	_rect(Vector2(22, 280), Vector2(160, 140), Color("#F9E4B0"))
	_rect(Vector2(26, 284), Vector2(152, 132), Color("#FAE8B8"))
	_label("JUEGOS\nINFANTILES", Vector2(56, 310), 9, Color("#E74C3C"))
	# Juegos
	_rect(Vector2(36, 340), Vector2(24, 40), Color("#E74C3C"))  # columpio
	_rect(Vector2(68, 340), Vector2(24, 40), Color("#3498DB"))
	_rect(Vector2(36, 336), Vector2(56, 6), Color("#8B4513"))
	_rect(Vector2(120, 330), Vector2(32, 50), Color("#F39C12"))  # resbaladilla
	_rect(Vector2(140, 380), Vector2(30, 6), Color("#E67E22"))

	# Macetas decorativas en caminos
	_maceta(Vector2(290, 160))
	_maceta(Vector2(336, 160))
	_maceta(Vector2(290, 350))
	_maceta(Vector2(336, 350))

	# Puerta de salida
	_rect(Vector2(276, 432), Vector2(88, 22), Color("#3A2A10"))
	_rect(Vector2(280, 434), Vector2(36, 18), Color("#4A3A18"))
	_rect(Vector2(320, 434), Vector2(36, 18), Color("#4A3A18"))
	_label("↓  Salida", Vector2(293, 436), 10, Color("#FFD080"))


func _banca_detallada(pos: Vector2) -> void:
	# Patas
	_rect(pos + Vector2(2, 18), Vector2(6, 12), Color("#3E2723"))
	_rect(pos + Vector2(42, 18), Vector2(6, 12), Color("#3E2723"))
	# Asiento
	_rect(pos, Vector2(50, 18), Color("#5D4037"))
	_rect(pos + Vector2(2, 2), Vector2(46, 14), Color("#795548"))
	# Respaldo
	_rect(pos + Vector2(0, -12), Vector2(50, 10), Color("#5D4037"))
	_rect(pos + Vector2(2, -10), Vector2(46, 6), Color("#6D4C41"))


func _arbol_grande(pos: Vector2) -> void:
	# Sombra
	_rect(pos + Vector2(10, 36), Vector2(30, 10), Color(0, 0, 0, 0.2))
	# Tronco
	_rect(pos + Vector2(16, 24), Vector2(14, 24), Color("#5D4037"))
	_rect(pos + Vector2(18, 26), Vector2(10, 22), Color("#6D4C41"))
	# Copa multicapa
	_rect(pos + Vector2(4,  14), Vector2(38, 22), Color("#1E8449"))
	_rect(pos + Vector2(0,  4),  Vector2(46, 16), Color("#27AE60"))
	_rect(pos + Vector2(6,  -8), Vector2(34, 16), Color("#2ECC71"))
	_rect(pos + Vector2(12, -18), Vector2(22, 14), Color("#58D68D"))
	# Brillos
	_rect(pos + Vector2(14, -14), Vector2(10, 6), Color("#82E0AA"))


func _arbusto(pos: Vector2) -> void:
	_rect(pos, Vector2(24, 18), Color("#1E8449"))
	_rect(pos + Vector2(2, -6), Vector2(20, 12), Color("#27AE60"))
	_rect(pos + Vector2(6, -10), Vector2(12, 8), Color("#2ECC71"))


func _kiosco(pos: Vector2) -> void:
	# Base
	_rect(pos, Vector2(68, 64), Color("#B5451B"))
	# Techo
	_rect(pos + Vector2(-4, -16), Vector2(76, 18), Color("#E67E22"))
	_rect(pos + Vector2(0, -12), Vector2(68, 14), Color("#D35400"))
	# Ventana
	_rect(pos + Vector2(6, 8), Vector2(56, 32), Color("#C0392B"))
	_rect(pos + Vector2(8, 10), Vector2(52, 28), Color("#E74C3C"))
	_label("KIOSCO", pos + Vector2(12, 14), 8, Color("#FFFFFF"))
	_label("Antojitos", pos + Vector2(14, 24), 7, Color("#FFE0A0"))
