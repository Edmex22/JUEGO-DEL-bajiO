extends "res://scripts/interior_base.gd"

# El "interior" del parque es un área al aire libre amplia
func _dibujar_fondo() -> void:
	# Pasto base
	for fy in range(0, alto, 32):
		for fx in range(0, ancho, 32):
			var c := Color("#5EAA40") if ((fx/32 + fy/32) % 2 == 0) else Color("#68B848")
			_rect(Vector2(fx, fy), Vector2(32, 32), c)

	# Borde del parque (reja/bardas)
	_rect(Vector2(0, 0),   Vector2(ancho, 12), Color("#4A3A20"))
	_rect(Vector2(0, 468), Vector2(ancho, 12), Color("#4A3A20"))
	_rect(Vector2(0, 0),   Vector2(12, alto),  Color("#4A3A20"))
	_rect(Vector2(628, 0), Vector2(12, alto),  Color("#4A3A20"))

	# Fuente central
	_rect(Vector2(264, 168), Vector2(112, 112), Color("#2980B9"))
	_rect(Vector2(272, 176), Vector2(96,  96),  Color("#3498DB"))
	_rect(Vector2(296, 200), Vector2(48,  48),  Color("#1A6A9A"))
	_rect(Vector2(308, 210), Vector2(24,  28),  Color("#5DADE2"))
	_label("⛲", Vector2(306, 208), 18, Color("#FFFFFF"))

	# Caminos de gravilla hacia la fuente (4 caminos cardinales)
	_rect(Vector2(295, 100), Vector2(50, 70),  Color("#C8B89A"))   # norte
	_rect(Vector2(295, 280), Vector2(50, 90),  Color("#C8B89A"))   # sur
	_rect(Vector2(100, 195), Vector2(166, 50), Color("#C8B89A"))   # oeste
	_rect(Vector2(374, 195), Vector2(166, 50), Color("#C8B89A"))   # este

	# Bancas alrededor de la fuente
	_banca(Vector2(232, 188))
	_banca(Vector2(380, 188))
	_banca(Vector2(232, 300))
	_banca(Vector2(380, 300))

	# Árboles grandes
	_arbol(Vector2(80,  80))
	_arbol(Vector2(520, 80))
	_arbol(Vector2(80,  360))
	_arbol(Vector2(520, 360))
	_arbol(Vector2(180, 120))
	_arbol(Vector2(420, 120))

	# Kiosco de comida (esquina)
	_rect(Vector2(30,  200), Vector2(64, 60), Color("#D35400"))
	_rect(Vector2(30,  190), Vector2(64, 14), Color("#E67E22"))
	_label("Kiosco", Vector2(38, 236), 8, Color("#FFFFFF"))

	# Zona de juegos infantiles
	_rect(Vector2(460, 280), Vector2(140, 120), Color("#F9E4B0"))
	_label("🎡 Juegos", Vector2(470, 340), 9, Color("#E74C3C"))

	# Letrero entrada
	_rect(Vector2(240, 4), Vector2(160, 20), Color("#2D5A14"))
	_label("PARQUE CENTRAL", Vector2(250, 8), 9, Color("#90EE60"))

	# Puerta de salida (realmente es la entrada del parque al mapa)
	_rect(Vector2(284, 440), Vector2(72, 28), Color("#4A3A20"))
	_label("Salida", Vector2(302, 446), 10, Color("#FFD080"))


func _banca(pos: Vector2) -> void:
	_rect(pos, Vector2(48, 20), Color("#5D4037"))
	_rect(pos + Vector2(4, -8), Vector2(40, 10), Color("#795548"))


func _arbol(pos: Vector2) -> void:
	# Tronco
	_rect(pos + Vector2(14, 20), Vector2(12, 20), Color("#5D4037"))
	# Copa (3 capas)
	_rect(pos + Vector2(4,  10), Vector2(32, 22), Color("#27AE60"))
	_rect(pos + Vector2(0,  0),  Vector2(40, 16), Color("#2ECC71"))
	_rect(pos + Vector2(8,  -8), Vector2(24, 12), Color("#58D68D"))
