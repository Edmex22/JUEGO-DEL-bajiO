extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# Piso mármol elegante
	for fy in range(0, alto, 48):
		for fx in range(0, ancho, 48):
			var c := Color("#E8E0D0") if ((fx/48 + fy/48) % 2 == 0) else Color("#F0E8D8")
			_rect(Vector2(fx, fy), Vector2(48, 48), c)

	# Pared norte azul banco
	_rect(Vector2(0, 0), Vector2(ancho, 60), Color("#1A3A6A"))
	_rect(Vector2(0, 56), Vector2(ancho, 6), Color("#F39C12"))

	# Zoclos dorados
	_rect(Vector2(0, 0),   Vector2(20, alto), Color("#2A4A7A"))
	_rect(Vector2(620, 0), Vector2(20, alto), Color("#2A4A7A"))

	# Letrero banco
	_label("BANCO MUNICIPAL", Vector2(196, 14), 14, Color("#F39C12"))
	_label("San Brasa del Monte — Sucursal Centro", Vector2(148, 34), 9, Color("#AACCFF"))

	# Signo de $ decorativo
	_label("$", Vector2(56, 10), 28, Color("#F39C12"))
	_label("$", Vector2(556, 10), 28, Color("#F39C12"))

	# Bóveda / caja fuerte (fondo izquierdo)
	_rect(Vector2(30, 100), Vector2(140, 160), Color("#4A4A4A"))
	_rect(Vector2(36, 106), Vector2(128, 148), Color("#2A2A2A"))
	_rect(Vector2(56, 126), Vector2(88, 108), Color("#1A1A1A"))
	# Manivela de la bóveda
	_rect(Vector2(94, 168), Vector2(16, 16), Color("#C0C0C0"))
	_label("BÓVEDA", Vector2(56, 258), 8, Color("#888888"))

	# Cajeros automáticos
	for i in range(3):
		_cajero(Vector2(220 + i * 120, 100))

	# Sillas de espera
	for sx in range(4):
		_silla(Vector2(100 + sx * 110, 300))

	# Barrera de cola (serpentina)
	for bx in range(5):
		_rect(Vector2(90 + bx * 90, 380), Vector2(8, 40), Color("#F39C12"))
		if bx < 4:
			var y_cord := 380 if bx % 2 == 0 else 416
			_rect(Vector2(98 + bx * 90, y_cord), Vector2(82, 4), Color("#F39C12"))

	# Ventanillas de atención
	for i in range(2):
		_ventanilla_banco(Vector2(420 + i * 130, 100), "Caja " + str(i + 1))

	# Puerta a gerencia
	_puerta_interior(Vector2(544, 360), "Gerencia")

	# Puerta de salida
	_rect(Vector2(284, 432), Vector2(72, 48), Color("#1A3A6A"))
	_label("Salida", Vector2(300, 446), 10, Color("#F39C12"))


func _cajero(pos: Vector2) -> void:
	_rect(pos, Vector2(80, 100), Color("#333333"))
	_rect(pos + Vector2(6, 10), Vector2(68, 40), Color("#1A3A6A"))
	_rect(pos + Vector2(10, 14), Vector2(60, 32), Color("#3A6AAA"))
	_rect(pos + Vector2(20, 56), Vector2(40, 16), Color("#222222"))
	_rect(pos + Vector2(28, 74), Vector2(24, 8),  Color("#555555"))
	_label("ATM", pos + Vector2(28, 84), 8, Color("#F39C12"))


func _ventanilla_banco(pos: Vector2, nombre: String) -> void:
	_rect(pos, Vector2(100, 120), Color("#2A4A7A"))
	_rect(pos + Vector2(4, 4), Vector2(92, 80), Color("#1A2A5A"))
	_rect(pos + Vector2(4, 4), Vector2(92, 60), Color("#1E3A8A"))
	_rect(pos + Vector2(0, 90), Vector2(100, 28), Color("#1A3A6A"))
	_label(nombre, pos + Vector2(24, 100), 9, Color("#F39C12"))
