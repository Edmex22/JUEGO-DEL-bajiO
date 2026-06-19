extends "res://scripts/interior_base.gd"

# ── Recepción de la Presidencia Municipal ────────────────────────────────────
# Composición por zonas para evitar amontonamiento:
#   · Pared norte (y 0-72): rótulo institucional + ventanas en esquinas
#   · Registro superior (y 92-185): cuadros enmarcados en muros + banderas al centro
#   · Zona central (y 185-275): mostrador de recepción enmarcado por columnas
#   · Zona inferior (y 290-455): sala de espera a la izquierda, plantas a la derecha
# Las puertas laterales tienen su hueco real en las paredes (ver _agregar_paredes).


func _agregar_paredes() -> void:
	# Norte completo
	_colision(Vector2(0, 0), Vector2(ancho, 92))
	# Oeste: hueco para puerta al Despacho (y 200-272)
	_colision(Vector2(0, 0), Vector2(22, 200))
	_colision(Vector2(0, 272), Vector2(22, alto - 272))
	# Este: hueco para puerta a Sala de Juntas (y 220-292)
	_colision(Vector2(ancho - 22, 0), Vector2(22, 220))
	_colision(Vector2(ancho - 22, 292), Vector2(22, alto - 292))
	# Sur con paso central hacia la salida
	_colision(Vector2(0, alto - 20), Vector2(260, 20))
	_colision(Vector2(380, alto - 20), Vector2(260, 20))


func _dibujar_fondo() -> void:
	_piso()
	_muros()
	_rotulo_y_ventanas()
	_iluminacion()
	_cuadros_de_muro()
	_banderas_centrales()
	_columnas_de_recepcion()
	_mostrador_recepcion()
	_sala_de_espera()
	_vegetacion()
	_puertas()


# ── Arquitectura ─────────────────────────────────────────────────────────────

func _piso() -> void:
	for fy in range(0, alto, 48):
		for fx in range(0, ancho, 48):
			var c := Color("#CBBFA8") if ((fx / 48 + fy / 48) % 2 == 0) else Color("#D8CCB4")
			_rect(Vector2(fx, fy), Vector2(48, 48), c)
			_rect(Vector2(fx, fy), Vector2(48, 2), Color("#B0A488"))
			_rect(Vector2(fx, fy), Vector2(2, 48), Color("#B0A488"))


func _muros() -> void:
	# Pared norte con moldura dorada — pixel art texture
	_rect(Vector2(0, 0), Vector2(ancho, 72), Color("#EAE0CC"))
	_rect(Vector2(0, 64), Vector2(ancho, 5), Color("#C8A860"))
	_rect(Vector2(0, 69), Vector2(ancho, 3), Color("#8B7340"))
	# Zoclos laterales
	_rect(Vector2(0, 0),   Vector2(20, alto), Color("#C8BC9A"))
	_rect(Vector2(620, 0), Vector2(20, alto), Color("#C8BC9A"))
	_rect(Vector2(18, 0),  Vector2(3, alto),  Color("#B0A480"))
	_rect(Vector2(619, 0), Vector2(3, alto),  Color("#B0A480"))


func _rotulo_y_ventanas() -> void:
	# Rótulo institucional centrado DENTRO de la pared
	_rect(Vector2(176, 8), Vector2(288, 54), Color("#F2EAD8"))
	_rect(Vector2(176, 8), Vector2(288, 3), Color("#C8A860"))
	_rect(Vector2(176, 59), Vector2(288, 3), Color("#C8A860"))
	_label("PRESIDENCIA MUNICIPAL", Vector2(202, 12), 13, Color("#5A3A10"))
	_label("H. Ayuntamiento de San Brasa del Monte", Vector2(208, 32), 7, Color("#7A5A30"))
	_label("Guanajuato, México", Vector2(262, 46), 6, Color("#9A7A50"))
	# Ventanas en las esquinas de la pared norte
	_ventana(Vector2(48, 16))
	_rect(Vector2(42, 12), Vector2(8, 46), Color("#C8A860"))
	_rect(Vector2(98, 12), Vector2(8, 46), Color("#C8A860"))
	_ventana(Vector2(540, 16))
	_rect(Vector2(534, 12), Vector2(8, 46), Color("#C8A860"))
	_rect(Vector2(590, 12), Vector2(8, 46), Color("#C8A860"))


func _iluminacion() -> void:
	_lampara(Vector2(110, 0))
	_lampara(Vector2(310, 0))
	_lampara(Vector2(510, 0))


# ── Decoración de muros ──────────────────────────────────────────────────────

func _cuadros_de_muro() -> void:
	# Muro izquierdo (dos cuadros apilados, sin nada que los tape)
	_cuadro_enmarcado(Vector2(30, 100), Vector2(96, 60), Color("#C8A860"), Color("#2C4A8A"), "Constitución\nMunicipal")
	_cuadro_enmarcado(Vector2(30, 176), Vector2(96, 60), Color("#8B6914"), Color("#1A3A1A"), "Reglamento\nInterno")
	# Muro derecho (dos cuadros apilados)
	_cuadro_enmarcado(Vector2(514, 100), Vector2(96, 60), Color("#C8A860"), Color("#4A2C2C"), "Plan de\nDesarrollo")
	_cuadro_enmarcado(Vector2(514, 176), Vector2(96, 60), Color("#8B6914"), Color("#1A3A1A"), "Bando\nMunicipal")


func _banderas_centrales() -> void:
	# Par de astas centradas, debajo del rótulo
	_bandera(Vector2(286, 96))
	_bandera(Vector2(330, 96))
	# Placa de escudo entre banderas y mostrador
	_rect(Vector2(264, 92), Vector2(16, 16), Color("#8B6914"))
	_rect(Vector2(360, 92), Vector2(16, 16), Color("#8B6914"))


# ── Zona de recepción ────────────────────────────────────────────────────────

func _columnas_de_recepcion() -> void:
	# Dos columnas que ENMARCAN el mostrador, en canales verticales libres
	# (entre los cuadros laterales y el mostrador), sin cruzar la alfombra
	_columna(Vector2(140, 72), 198)
	_columna(Vector2(480, 72), 198)


func _mostrador_recepcion() -> void:
	# Panel de turnos colgado sobre el mostrador
	_rect(Vector2(270, 150), Vector2(140, 22), Color("#1A1A1A"))
	_rect(Vector2(274, 153), Vector2(132, 16), Color("#222222"))
	_label("TURNO ACTUAL:  B-017", Vector2(282, 155), 7, Color("#00FF66"))

	# Mostrador centrado
	_sombra(Vector2(176, 196), Vector2(288, 64))
	_colision(Vector2(176, 192), Vector2(288, 70))
	_mostrador(Vector2(176, 200), 288, Color("#8B6914"))
	# Letrero RECEPCIÓN al frente
	_rect(Vector2(260, 218), Vector2(120, 16), Color("#A07820"))
	_label("RECEPCIÓN", Vector2(282, 221), 9, Color("#FFE080"))
	# Equipo sobre el mostrador
	_rect(Vector2(388, 184), Vector2(40, 28), Color("#1A1A1A"))
	_rect(Vector2(392, 188), Vector2(32, 20), Color("#3A9FD4"))
	_rect(Vector2(402, 212), Vector2(10, 6), Color("#2A2A2A"))
	_rect(Vector2(386, 218), Vector2(44, 8), Color("#333333"))
	_rect(Vector2(204, 190), Vector2(28, 10), Color("#222222"))
	_rect(Vector2(207, 187), Vector2(22, 4), Color("#333333"))


# ── Zona inferior ────────────────────────────────────────────────────────────

func _sala_de_espera() -> void:
	# Alfombra de espera a la izquierda, sin columnas encima
	_sombra(Vector2(30, 296), Vector2(244, 150))
	_alfombra(Vector2(30, 296), Vector2(244, 150), Color("#8B1A1A"))
	# Borde decorativo encima de la textura
	_rect(Vector2(30, 296), Vector2(244, 4), Color("#8B1A1A").darkened(0.3))
	_rect(Vector2(30, 442), Vector2(244, 4), Color("#8B1A1A").darkened(0.3))
	_rect(Vector2(30, 296), Vector2(4, 150), Color("#8B1A1A").darkened(0.3))
	_rect(Vector2(270, 296), Vector2(4, 150), Color("#8B1A1A").darkened(0.3))
	_colision(Vector2(30, 296), Vector2(244, 150))
	# Dos hileras de sillas mirando al centro
	for sx in range(4):
		_silla(Vector2(44 + sx * 56, 308))
	for sx in range(4):
		_silla(Vector2(44 + sx * 56, 392))
	# Mesa de centro con material informativo
	_rect(Vector2(96, 350), Vector2(112, 30), Color("#6B4A20"))
	_rect(Vector2(99, 353), Vector2(106, 24), Color("#8B6A30"))
	_rect(Vector2(106, 356), Vector2(30, 16), Color("#E74C3C"))
	_label("Ley", Vector2(111, 359), 6, Color("#FFFFFF"))
	_rect(Vector2(144, 356), Vector2(30, 16), Color("#3498DB"))


func _vegetacion() -> void:
	# Plantas SOLO en zonas libres del lado derecho y esquinas inferiores
	_planta_grande(Vector2(360, 388))
	_planta_grande(Vector2(440, 312))
	_planta_grande(Vector2(560, 388))


func _puertas() -> void:
	# Puerta al Despacho — pared oeste
	_puerta_interior(Vector2(-6, 208), "← Despacho del\nPresidente")
	# Puerta a Sala de Juntas — pared este
	_puerta_interior(Vector2(584, 228), "Sala de →\nJuntas")
	# Salida — sur
	_rect(Vector2(280, 424), Vector2(80, 56), Color("#5A3020"))
	_rect(Vector2(284, 428), Vector2(34, 48), Color("#6B3A28"))
	_rect(Vector2(322, 428), Vector2(34, 48), Color("#6B3A28"))
	_rect(Vector2(315, 452), Vector2(10, 10), Color("#C8A860"))
	_label("↓  Salida", Vector2(294, 444), 10, Color("#FFD080"))
