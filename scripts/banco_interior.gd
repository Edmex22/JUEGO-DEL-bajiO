extends "res://scripts/interior_base.gd"

func _dibujar_fondo() -> void:
	# ── PISO: mármol crema con veta dorada ──────────────────────────────────────
	for fy in range(0, alto, 64):
		for fx in range(0, ancho, 64):
			var c := Color("#F0E8D8") if ((fx/64 + fy/64) % 2 == 0) else Color("#E4D8C4")
			_rect(Vector2(fx, fy), Vector2(64, 64), c)
	# Grout dorado fino
	for fy in range(0, alto, 64):
		_rect(Vector2(0, fy), Vector2(ancho, 2), Color("#C8A060"))
	for fx in range(0, ancho, 64):
		_rect(Vector2(fx, 0), Vector2(2, alto), Color("#C8A060"))

	# ── PARED NORTE ─────────────────────────────────────────────────────────────
	_rect(Vector2(0, 0), Vector2(ancho, 92), Color("#0D2650"))
	_rect(Vector2(0, 86), Vector2(ancho, 8), Color("#F39C12"))
	_rect(Vector2(0, 92), Vector2(ancho, 18), Color("#142E60"))
	_rect(Vector2(0, 108), Vector2(ancho, 4), Color("#0A1E40"))

	# Zoclos con acento dorado
	_rect(Vector2(0,   0), Vector2(26, alto), Color("#0D2650"))
	_rect(Vector2(614, 0), Vector2(26, alto), Color("#0D2650"))
	_rect(Vector2(24,  0), Vector2(4, alto),  Color("#F39C12"))
	_rect(Vector2(612, 0), Vector2(4, alto),  Color("#F39C12"))

	# ── LETRERO ─────────────────────────────────────────────────────────────────
	_rect(Vector2(188, 12), Vector2(264, 52), Color("#0D2650"))
	_label("BANCO MUNICIPAL", Vector2(196, 18), 16, Color("#F39C12"))
	_label("San Brasa del Monte  ·  Sucursal Centro", Vector2(166, 44), 8, Color("#AACCFF"))

	# Signos de $ grandes en los extremos
	_rect(Vector2(44, 12), Vector2(52, 52), Color("#142E60"))
	_label("$", Vector2(58, 14), 28, Color("#F39C12"))
	_rect(Vector2(544, 12), Vector2(52, 52), Color("#142E60"))
	_label("$", Vector2(558, 14), 28, Color("#F39C12"))

	# ── LÁMPARAS ────────────────────────────────────────────────────────────────
	_lampara(Vector2(156, 0))
	_lampara(Vector2(296, 0))
	_lampara(Vector2(436, 0))

	# ── BÓVEDA (esquina izquierda, compacta) ────────────────────────────────────
	_sombra(Vector2(30, 112), Vector2(130, 170))
	_rect(Vector2(30, 112), Vector2(130, 170), Color("#2E2E2E"))
	_rect(Vector2(34, 116), Vector2(122, 162), Color("#1E1E1E"))
	_rect(Vector2(44, 126), Vector2(102, 130), Color("#383838"))
	_rect(Vector2(48, 130), Vector2(94, 122), Color("#141414"))
	# Rueda de la bóveda
	_rect(Vector2(82, 172), Vector2(28, 28), Color("#808080"))
	_rect(Vector2(86, 176), Vector2(20, 20), Color("#B0B0B0"))
	_rect(Vector2(94, 184), Vector2(4,  4),  Color("#707070"))
	# Barras horizontales
	for bi in range(3):
		_rect(Vector2(52, 138 + bi * 32), Vector2(86, 8), Color("#282828"))
	_label("BÓVEDA", Vector2(54, 278), 9, Color("#888888"))
	# Colisión bóveda
	_colision(Vector2(30, 112), Vector2(130, 175))

	# ── ZONA ATM (centro-izquierda, bien espaciada) ──────────────────────────────
	_label("CAJEROS AUTOMÁTICOS", Vector2(188, 112), 8, Color("#AACCFF"))
	for i in range(2):
		var cx := 188 + i * 116
		_sombra(Vector2(cx, 126), Vector2(94, 120))
		_cajero(Vector2(cx, 126))
		_colision(Vector2(cx, 126), Vector2(94, 120))

	# ── MAMPARA DE VIDRIO (línea separadora elegante) ───────────────────────────
	_rect(Vector2(415, 92), Vector2(8, 330), Color("#142E60"))
	_rect(Vector2(419, 92), Vector2(4, 330), Color("#1E3870"))
	_rect(Vector2(415, 92), Vector2(210, 6), Color("#F39C12"))
	_rect(Vector2(415, 418), Vector2(210, 6), Color("#F39C12"))
	_colision(Vector2(415, 92), Vector2(8, 330))

	# ── VENTANILLAS DE CAJA (lado derecho, amplio) ──────────────────────────────
	_label("ATENCIÓN AL CLIENTE", Vector2(452, 112), 8, Color("#F39C12"))
	_ventanilla_banco(Vector2(430, 130), "Caja 1")
	_ventanilla_banco(Vector2(430, 290), "Caja 2")
	_colision(Vector2(430, 130), Vector2(180, 140))
	_colision(Vector2(430, 290), Vector2(180, 140))

	# ── ZONA DE ESPERA (zona sur, amplia y cómoda) ──────────────────────────────
	_alfombra(Vector2(30, 300), Vector2(370, 108), Color("#0D2650"))

	# Barrera de cola serpentina (elegante)
	var postes := [Vector2(50, 305), Vector2(160, 305), Vector2(270, 305),
				   Vector2(270, 390), Vector2(160, 390), Vector2(50, 390)]
	for bp in postes:
		_rect(bp, Vector2(8, 50), Color("#F39C12"))
	# Cordones de la serpentina
	_rect(Vector2(58, 307), Vector2(102, 5), Color("#C8A030"))
	_rect(Vector2(160, 307), Vector2(110, 5), Color("#C8A030"))
	_rect(Vector2(270, 357), Vector2(8, 35), Color("#F39C12"))
	_rect(Vector2(58, 392), Vector2(212, 5), Color("#C8A030"))

	# Sillas de espera — dos filas separadas
	for sx in range(4):
		_silla(Vector2(50 + sx * 76, 315))
	for sx in range(4):
		_silla(Vector2(50 + sx * 76, 400))
	# Mesa con formularios entre las filas
	_sombra(Vector2(186, 354), Vector2(68, 36))
	_rect(Vector2(186, 354), Vector2(68, 36), Color("#142E60"))
	_rect(Vector2(190, 358), Vector2(60, 28), Color("#1A3A70"))
	_label("Formularios", Vector2(194, 368), 7, Color("#F39C12"))

	# ── CUADROS INFORMATIVOS (norte, sobre la bóveda y cajeros) ─────────────────
	_cuadro_enmarcado(Vector2(30, 300), Vector2(0, 0), Color("#F39C12"), Color("#0D2650"), "")  # placeholder vacío para no solapar

	# ── PLANTA DECORATIVA ────────────────────────────────────────────────────────
	_planta_grande(Vector2(28, 290))
	_planta_grande(Vector2(568, 290))

	# ── PUERTA A GERENCIA ────────────────────────────────────────────────────────
	_puerta_interior(Vector2(540, 345), "→ Gerencia")
	_colision(Vector2(540, 345), Vector2(56, 72))  # bloqueada hasta que abres

	# ── PUERTA DE SALIDA ─────────────────────────────────────────────────────────
	_rect(Vector2(272, 420), Vector2(96, 60), Color("#0D2650"))
	_rect(Vector2(276, 424), Vector2(40, 52), Color("#142E60"))
	_rect(Vector2(324, 424), Vector2(40, 52), Color("#142E60"))
	_rect(Vector2(312, 446), Vector2(14, 14), Color("#F39C12"))
	_label("↓  Salida", Vector2(289, 444), 10, Color("#F39C12"))


func _cajero(pos: Vector2) -> void:
	_rect(pos, Vector2(92, 118), Color("#242424"))
	_rect(pos + Vector2(3, 3), Vector2(86, 112), Color("#2E2E2E"))
	# Pantalla
	_rect(pos + Vector2(8, 10), Vector2(76, 48), Color("#071828"))
	_rect(pos + Vector2(12, 14), Vector2(68, 40), Color("#0D2850"))
	_label("ATM", pos + Vector2(34, 22), 11, Color("#F39C12"))
	_label("Inserte tarjeta", pos + Vector2(20, 36), 7, Color("#AACCFF"))
	# Ranura tarjeta
	_rect(pos + Vector2(20, 62), Vector2(52, 7), Color("#111111"))
	# Teclado
	_rect(pos + Vector2(16, 74), Vector2(60, 30), Color("#1A1A1A"))
	for ty in range(3):
		for tx in range(3):
			_rect(pos + Vector2(20 + tx * 18, 78 + ty * 9), Vector2(14, 7), Color("#2A2A2A"))
	# Ranura dinero
	_rect(pos + Vector2(20, 108), Vector2(52, 7), Color("#0A0A0A"))
	_label("$", pos + Vector2(22, 108), 7, Color("#888"))


func _ventanilla_banco(pos: Vector2, nombre: String) -> void:
	_rect(pos, Vector2(178, 148), Color("#0D2650"))
	_rect(pos + Vector2(4, 4), Vector2(170, 140), Color("#091E42"))
	# Vidrio con tinte
	_rect(pos + Vector2(4, 4), Vector2(170, 96), Color("#071428"))
	_rect(pos + Vector2(6, 6), Vector2(54, 30), Color("#0C1E38"))  # reflejo
	# Rendija
	_rect(pos + Vector2(50, 64), Vector2(78, 5), Color("#222"))
	# Mostrador
	_rect(pos + Vector2(0, 104), Vector2(178, 42), Color("#0D2650"))
	_rect(pos + Vector2(0, 100), Vector2(178, 6), Color("#F39C12"))
	# Nombre y estado
	_label(nombre, pos + Vector2(54, 112), 11, Color("#F39C12"))
	_rect(pos + Vector2(110, 8), Vector2(58, 18), Color("#071E0A"))
	_label("● ABIERTA", pos + Vector2(112, 10), 7, Color("#00DD44"))
