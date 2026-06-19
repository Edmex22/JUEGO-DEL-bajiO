extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso mármol elegante con grout dorado
	for fy in range(0, alto, 48):
		for fx in range(0, ancho, 48):
			var c := Color("#E8E0D0") if ((fx/48 + fy/48) % 2 == 0) else Color("#F0E8D8")
			_rect(Vector2(fx, fy), Vector2(48, 48), c)
			_rect(Vector2(fx, fy), Vector2(48, 2), Color("#C8A860"))
			_rect(Vector2(fx, fy), Vector2(2, 48), Color("#C8A860"))

	# Pared norte azul banco con moldura dorada
	_rect(Vector2(0, 0), Vector2(ancho, 68), Color("#0F2A5A"))
	_rect(Vector2(0, 64), Vector2(ancho, 6), Color("#F39C12"))
	_rect(Vector2(0, 68), Vector2(ancho, 3), Color("#C07A00"))

	# Zoclos dorados
	_rect(Vector2(0, 0),   Vector2(22, alto), Color("#1A3A6A"))
	_rect(Vector2(618, 0), Vector2(22, alto), Color("#1A3A6A"))
	_rect(Vector2(20, 0),  Vector2(4, alto),  Color("#F39C12"))
	_rect(Vector2(616, 0), Vector2(4, alto),  Color("#F39C12"))

	# Letrero banco con signo de pesos
	_rect(Vector2(40, 10), Vector2(48, 44), Color("#1A3A6A"))
	_label("$", Vector2(52, 14), 26, Color("#F39C12"))
	_rect(Vector2(552, 10), Vector2(48, 44), Color("#1A3A6A"))
	_label("$", Vector2(564, 14), 26, Color("#F39C12"))
	_label("BANCO MUNICIPAL", Vector2(186, 14), 16, Color("#F39C12"))
	_label("San Brasa del Monte  ·  Sucursal Centro", Vector2(148, 38), 9, Color("#AACCFF"))

	# Lámparas elegantes
	_lampara(Vector2(96, 0))
	_lampara(Vector2(220, 0))
	_lampara(Vector2(420, 0))
	_lampara(Vector2(544, 0))

	# Alfombra de espera
	_alfombra(Vector2(80, 290), Vector2(380, 120), Color("#0F2A5A"))

	# Bóveda / caja fuerte detallada
	_rect(Vector2(24, 90), Vector2(148, 200), Color("#3A3A3A"))
	_rect(Vector2(28, 94), Vector2(140, 192), Color("#2A2A2A"))
	# Puerta de bóveda circular
	_rect(Vector2(44, 110), Vector2(108, 150), Color("#4A4A4A"))
	_rect(Vector2(48, 114), Vector2(100, 142), Color("#1A1A1A"))
	# Manivela central
	_rect(Vector2(88, 174), Vector2(24, 24), Color("#888888"))
	_rect(Vector2(92, 178), Vector2(16, 16), Color("#C0C0C0"))
	_rect(Vector2(98, 184), Vector2(4, 4), Color("#888888"))
	# Barras de la bóveda
	for by in range(4):
		_rect(Vector2(56, 122 + by * 30), Vector2(88, 6), Color("#333333"))
	_label("BÓVEDA", Vector2(62, 292), 9, Color("#888888"))
	_label("PRINCIPAL", Vector2(58, 304), 9, Color("#666666"))

	# Cajeros automáticos con más detalle
	for i in range(3):
		_cajero(Vector2(196 + i * 108, 90))

	# Mampara de vidrio / separador
	_rect(Vector2(420, 68), Vector2(6, 310), Color("#1A3A6A"))
	_rect(Vector2(424, 68), Vector2(190, 4), Color("#F39C12"))
	_rect(Vector2(424, 374), Vector2(190, 4), Color("#F39C12"))

	# Ventanillas de caja (lado derecho)
	_ventanilla_banco(Vector2(428, 90), "Caja 1")
	_ventanilla_banco(Vector2(428, 230), "Caja 2")

	# Barrera de cola serpentina
	for bx in range(5):
		_rect(Vector2(80 + bx * 68, 380), Vector2(8, 48), Color("#F39C12"))
		if bx < 4:
			var y_c := 380 if bx % 2 == 0 else 424
			_rect(Vector2(88 + bx * 68, y_c), Vector2(60, 6), Color("#F39C12"))

	# Sillas de espera con diseño
	for sx in range(4):
		_silla(Vector2(92 + sx * 88, 302))
	# Mesita con formularios
	_rect(Vector2(248, 355), Vector2(60, 18), Color("#1A3A6A"))
	_rect(Vector2(252, 357), Vector2(52, 12), Color("#2A4A7A"))
	_label("Formularios", Vector2(254, 360), 7, Color("#F39C12"))

	# Cuadros informativos
	_cuadro_enmarcado(Vector2(184, 68), Vector2(80, 52), Color("#F39C12"), Color("#0F2A5A"), "Tasas\nvigentes\n8.5% anual")
	_cuadro_enmarcado(Vector2(276, 68), Vector2(80, 52), Color("#F39C12"), Color("#0F2A5A"), "Créditos\ndesde\n$10,000")

	# Plantas decorativas
	_planta_grande(Vector2(22, 300))

	# Puerta a gerencia
	_puerta_interior(Vector2(536, 360), "→ Gerencia")

	# Puerta de salida
	_rect(Vector2(276, 424), Vector2(88, 56), Color("#0F2A5A"))
	_rect(Vector2(280, 428), Vector2(36, 48), Color("#1A3A6A"))
	_rect(Vector2(320, 428), Vector2(36, 48), Color("#1A3A6A"))
	_rect(Vector2(312, 450), Vector2(12, 12), Color("#F39C12"))
	_label("↓  Salida", Vector2(293, 444), 10, Color("#F39C12"))


func _cajero(pos: Vector2) -> void:
	# Sombra
	_rect(pos + Vector2(3, 3), Vector2(90, 116), Color(0, 0, 0, 0.3))
	# Cuerpo
	_rect(pos, Vector2(88, 114), Color("#2A2A2A"))
	_rect(pos + Vector2(3, 3), Vector2(82, 108), Color("#333333"))
	# Pantalla
	_rect(pos + Vector2(8, 10), Vector2(72, 44), Color("#0A1A3A"))
	_rect(pos + Vector2(12, 14), Vector2(64, 36), Color("#1A4A8A"))
	_label("ATM", pos + Vector2(32, 24), 10, Color("#F39C12"))
	_label("Inserte\ntarjeta", pos + Vector2(24, 36), 7, Color("#AACCFF"))
	# Ranura de tarjeta
	_rect(pos + Vector2(22, 58), Vector2(44, 6), Color("#1A1A1A"))
	_rect(pos + Vector2(24, 59), Vector2(40, 4), Color("#111111"))
	# Teclado numérico
	_rect(pos + Vector2(18, 68), Vector2(52, 32), Color("#222222"))
	for ty in range(3):
		for tx in range(3):
			_rect(pos + Vector2(22 + tx * 16, 72 + ty * 10), Vector2(12, 8), Color("#333333"))
	# Ranura de dinero
	_rect(pos + Vector2(22, 104), Vector2(44, 6), Color("#1A1A1A"))
	_label("$ EFECTIVO", pos + Vector2(22, 104), 6, Color("#888888"))


func _ventanilla_banco(pos: Vector2, nombre: String) -> void:
	# Sombra
	_rect(pos + Vector2(3, 3), Vector2(178, 128), Color(0, 0, 0, 0.25))
	# Marco principal
	_rect(pos, Vector2(176, 126), Color("#1A3A6A"))
	_rect(pos + Vector2(3, 3), Vector2(170, 92), Color("#0F2A5A"))
	# Vidrio de la ventanilla con reflejo
	_rect(pos + Vector2(3, 3), Vector2(170, 78), Color("#0A1A40"))
	_rect(pos + Vector2(5, 5), Vector2(50, 28), Color("#0F2040"))
	# Rendija de comunicación
	_rect(pos + Vector2(60, 50), Vector2(56, 4), Color("#333333"))
	# Mostrador
	_rect(pos + Vector2(0, 96), Vector2(176, 28), Color("#1A3A6A"))
	_rect(pos + Vector2(0, 92), Vector2(176, 6), Color("#F39C12"))
	# Nombre
	_label(nombre, pos + Vector2(56, 102), 10, Color("#F39C12"))
	# Estado abierto
	_rect(pos + Vector2(120, 6), Vector2(50, 16), Color("#0A2A0A"))
	_label("● ABIERTA", pos + Vector2(122, 8), 7, Color("#00CC00"))
