extends "res://scripts/interior_base.gd"


func _dibujar_fondo() -> void:
	# Piso de cantera en cuadrícula
	for fy in range(0, alto, 48):
		for fx in range(0, ancho, 48):
			var dark := ((fx / 48) + (fy / 48)) % 2 == 0
			_rect(Vector2(fx, fy), Vector2(48, 48),
				Color("#CBBFA8") if dark else Color("#D8CCB4"))

	# Pared norte
	_rect(Vector2(0, 0), Vector2(ancho, 60), Color("#EAE0CC"))

	# Zoclos
	_rect(Vector2(0, 0),   Vector2(18, alto), Color("#C8BC9A"))
	_rect(Vector2(622, 0), Vector2(18, alto), Color("#C8BC9A"))

	# Ventanas
	_ventana(Vector2(80,  10))
	_ventana(Vector2(280, 10))
	_ventana(Vector2(480, 10))

	# Bandera
	_bandera(Vector2(300, 62))

	# Escudo / título
	_label("PRESIDENCIA MUNICIPAL", Vector2(160, 65), 12, Color("#5A3A10"))
	_label("San Brasa del Monte",   Vector2(210, 80),  9, Color("#7A5A30"))

	# Mostrador de recepción
	_rect(Vector2(160, 160), Vector2(320, 52), Color("#8B6914"))
	_rect(Vector2(160, 148), Vector2(320, 14), Color("#A07A1A"))
	# Teléfono sobre mostrador
	_rect(Vector2(200, 152), Vector2(24, 12), Color("#222222"))
	# Computadora
	_rect(Vector2(400, 138), Vector2(36, 28), Color("#2C2C2C"))
	_rect(Vector2(404, 142), Vector2(28, 18), Color("#3A9FD4"))

	# Sillas de espera (lado izquierdo)
	_silla(Vector2(40, 240))
	_silla(Vector2(40, 300))
	_silla(Vector2(100, 240))

	# Macetas decorativas
	_maceta(Vector2(22, 120))
	_maceta(Vector2(598, 120))
	_maceta(Vector2(22, 360))
	_maceta(Vector2(598, 360))

	# Puerta al Despacho del Presidente (norte, centro)
	_puerta_interior(Vector2(292, 88), "Despacho")

	# Puerta a Sala de Juntas (lado derecho)
	_puerta_interior(Vector2(540, 200), "Sala de Juntas")

	# Puerta de Salida (sur)
	_rect(Vector2(284, 432), Vector2(72, 48), Color("#5A3020"))
	_label("Salida", Vector2(300, 444), 10, Color("#FFD080"))

	# Cuadros en las paredes
	_rect(Vector2(30,  90), Vector2(48, 36), Color("#2C4A8A"))
	_label("Ley", Vector2(44, 100), 8, Color("#FFFFFF"))
	_rect(Vector2(560, 90), Vector2(48, 36), Color("#8A2C2C"))
	_label("Plan", Vector2(572, 100), 8, Color("#FFFFFF"))
