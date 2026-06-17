extends Node

signal evento_disparado(titulo: String, descripcion: String, opciones: Array)

# Opciones con formato: { "texto": String, "efecto": Callable }
func _emitir(titulo: String, desc: String, opciones: Array) -> void:
	emit_signal("evento_disparado", titulo, desc, opciones)


func evento_semana_floja() -> void:
	_emitir(
		"Semana floja para el comercio",
		"Los negocios del municipio reportan bajas ventas esta semana. La actividad económica cae.",
		[
			{ "texto": "Lanzar campaña de consumo local ($15,000)",
			  "efecto": func(): GameState.presupuesto_municipal -= 15000; GameState.actividad_economica += 3; GameState.empleo += 1 },
			{ "texto": "Aguantar y no gastar",
			  "efecto": func(): GameState.actividad_economica -= 2 },
		]
	)


func evento_apoyo_estatal() -> void:
	_emitir(
		"¡Apoyo estatal extraordinario!",
		"El gobierno del estado transfirió fondos adicionales al municipio este periodo.",
		[
			{ "texto": "Usar para infraestructura",
			  "efecto": func(): GameState.presupuesto_municipal += 16000; GameState.infraestructura += 3 },
			{ "texto": "Guardar en reserva",
			  "efecto": func(): GameState.presupuesto_municipal += 16000 },
		]
	)


func evento_rumores_corrupcion() -> void:
	_emitir(
		"Rumores de corrupción",
		"Circulan versiones sobre desvío de recursos en la administración municipal. La ciudadanía exige transparencia.",
		[
			{ "texto": "Convocar auditoría pública ($25,000)",
			  "efecto": func(): GameState.presupuesto_municipal -= 25000; GameState.corrupcion -= 8; GameState.aprobacion_ciudadana += 4 },
			{ "texto": "Ignorar los rumores",
			  "efecto": func(): GameState.corrupcion += 4; GameState.aprobacion_ciudadana -= 5 },
		]
	)


func evento_baja_empleo() -> void:
	_emitir(
		"Talleres reportan baja de empleo",
		"Varios talleres y negocios locales redujeron personal esta semana. El desempleo sube.",
		[
			{ "texto": "Subsidiar empleo temporal ($30,000)",
			  "efecto": func(): GameState.presupuesto_municipal -= 30000; GameState.empleo += 5; GameState.aprobacion_ciudadana += 2 },
			{ "texto": "Esperar que el mercado se recupere",
			  "efecto": func(): GameState.empleo -= 3 },
		]
	)


func evento_quejas_transporte() -> void:
	_emitir(
		"Quejas por transporte público",
		"Los ciudadanos se quejan masivamente de retrasos y malas condiciones del transporte.",
		[
			{ "texto": "Invertir en mantenimiento urgente ($40,000)",
			  "efecto": func(): GameState.presupuesto_municipal -= 40000; GameState.transporte += 6; GameState.aprobacion_ciudadana += 3 },
			{ "texto": "Prometer mejoras sin actuar",
			  "efecto": func(): GameState.aprobacion_ciudadana -= 4; GameState.transporte -= 2 },
		]
	)


func evento_actividad_comunitaria() -> void:
	_emitir(
		"Feria comunitaria espontánea",
		"Los vecinos organizaron una feria en el parque. El tejido social del municipio se fortalece.",
		[
			{ "texto": "Apoyar con recursos municipales ($10,000)",
			  "efecto": func(): GameState.presupuesto_municipal -= 10000; GameState.tejido_social += 6; GameState.aprobacion_ciudadana += 3 },
			{ "texto": "Dejar que los vecinos la organicen solos",
			  "efecto": func(): GameState.tejido_social += 2 },
		]
	)
