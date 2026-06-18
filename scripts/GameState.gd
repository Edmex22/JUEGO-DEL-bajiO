extends Node

signal dia_avanzado(dia: int)

# Posición donde el jugador debe aparecer al regresar del interior
var posicion_jugador_exterior: Vector2 = Vector2(0, 288)

var municipio_nombre: String = "San Brasa del Monte"
var dia_actual: int = 1

var presupuesto_municipal: int = 500000
var deuda_municipal: int = 0

var aprobacion_ciudadana: int = 55
var infraestructura: int = 48
var seguridad: int = 52
var actividad_economica: int = 60
var empleo: int = 55
var transporte: int = 45
var educacion: int = 50
var salud: int = 50
var tejido_social: int = 50
var corrupcion: int = 15

func reparar_calles() -> void:
	if presupuesto_municipal >= 50000:
		presupuesto_municipal -= 50000
		infraestructura += 8
		aprobacion_ciudadana += 3
		actividad_economica += 2
		_limitar_valores()
		print("Se repararon calles del municipio.")
	else:
		print("No hay presupuesto suficiente para reparar calles.")

func mejorar_seguridad() -> void:
	if presupuesto_municipal >= 40000:
		presupuesto_municipal -= 40000
		seguridad += 7
		aprobacion_ciudadana += 2
		_limitar_valores()
		print("Se mejoró la seguridad municipal.")
	else:
		print("No hay presupuesto suficiente para mejorar seguridad.")

func apoyar_negocios() -> void:
	if presupuesto_municipal >= 30000:
		presupuesto_municipal -= 30000
		actividad_economica += 7
		aprobacion_ciudadana += 1
		empleo += 2
		_limitar_valores()
		print("Se lanzó apoyo a negocios locales.")
	else:
		print("No hay presupuesto suficiente para apoyar negocios.")

func mejorar_educacion() -> void:
	if presupuesto_municipal >= 45000:
		presupuesto_municipal -= 45000
		educacion += 8
		aprobacion_ciudadana += 3
		actividad_economica += 1
		_limitar_valores()
		print("Se invirtió en educación municipal.")
	else:
		print("No hay presupuesto suficiente para educación.")

func mejorar_salud() -> void:
	if presupuesto_municipal >= 45000:
		presupuesto_municipal -= 45000
		salud += 8
		aprobacion_ciudadana += 3
		seguridad += 1
		_limitar_valores()
		print("Se invirtió en salud municipal.")
	else:
		print("No hay presupuesto suficiente para salud.")

func mantener_parque() -> void:
	if presupuesto_municipal >= 22000:
		presupuesto_municipal -= 22000
		tejido_social += 6
		seguridad += 2
		aprobacion_ciudadana += 1
		_limitar_valores()
		print("Se dio mantenimiento al parque municipal.")
	else:
		print("No hay presupuesto suficiente para mantener el parque.")

func auditoria_publica() -> void:
	if presupuesto_municipal >= 25000:
		presupuesto_municipal -= 25000
		corrupcion -= 6
		aprobacion_ciudadana += 2
		_limitar_valores()
		print("Se realizó una auditoría pública.")
	else:
		print("No hay presupuesto suficiente para auditoría pública.")

func mejorar_transporte() -> void:
	if presupuesto_municipal >= 55000:
		presupuesto_municipal -= 55000
		transporte += 8
		empleo += 3
		actividad_economica += 2
		_limitar_valores()
		print("Se mejoró el transporte municipal.")
	else:
		print("No hay presupuesto suficiente para mejorar transporte.")

func solicitar_prestamo_menor() -> void:
	presupuesto_municipal += 100000
	deuda_municipal += 115000
	aprobacion_ciudadana -= 1
	_limitar_valores()
	print("Se solicitó un préstamo menor.")

func solicitar_prestamo_obra() -> void:
	presupuesto_municipal += 250000
	deuda_municipal += 315000
	aprobacion_ciudadana -= 3
	_limitar_valores()
	print("Se solicitó un préstamo de obra.")

func solicitar_rescate_urgente() -> void:
	presupuesto_municipal += 500000
	deuda_municipal += 700000
	aprobacion_ciudadana -= 7
	_limitar_valores()

# ── SAT ───────────────────────────────────────────────────────────────────────
func sat_fiscalizacion() -> void:
	if presupuesto_municipal >= 20000:
		presupuesto_municipal -= 20000
		presupuesto_municipal += 45000  # recaudación extra
		corrupcion -= 4
		actividad_economica -= 2
		_limitar_valores()

func sat_simplificar_tramites() -> void:
	if presupuesto_municipal >= 15000:
		presupuesto_municipal -= 15000
		actividad_economica += 5
		empleo += 2
		aprobacion_ciudadana += 2
		_limitar_valores()

func sat_amnistia_fiscal() -> void:
	if presupuesto_municipal >= 10000:
		presupuesto_municipal -= 10000
		presupuesto_municipal += 80000  # contribuyentes se ponen al corriente
		aprobacion_ciudadana += 3
		corrupcion += 2
		_limitar_valores()

# ── Hospital ──────────────────────────────────────────────────────────────────
func hospital_contratar_medicos() -> void:
	if presupuesto_municipal >= 60000:
		presupuesto_municipal -= 60000
		salud += 12
		empleo += 3
		aprobacion_ciudadana += 4
		_limitar_valores()

func hospital_comprar_medicamentos() -> void:
	if presupuesto_municipal >= 25000:
		presupuesto_municipal -= 25000
		salud += 6
		aprobacion_ciudadana += 2
		_limitar_valores()

func hospital_campana_salud() -> void:
	if presupuesto_municipal >= 18000:
		presupuesto_municipal -= 18000
		salud += 5
		tejido_social += 3
		aprobacion_ciudadana += 3
		_limitar_valores()

func avanzar_dia() -> void:
	dia_actual += 1

	var ingreso_diario := calcular_ingreso_diario()
	var gasto_operativo := calcular_gasto_operativo_diario()

	presupuesto_municipal += ingreso_diario
	presupuesto_municipal -= gasto_operativo

	if deuda_municipal > 0:
		var interes_diario := int(deuda_municipal * 0.001)
		deuda_municipal += interes_diario
		presupuesto_municipal -= interes_diario

	if presupuesto_municipal < 0:
		presupuesto_municipal = 0
		aprobacion_ciudadana -= 2

	if dia_actual % 5 == 0:
		infraestructura -= 1

	if dia_actual % 7 == 0:
		_aplicar_evento_semanal()

	_recalcular_aprobacion()
	_limitar_valores()
	emit_signal("dia_avanzado", dia_actual)

func calcular_ingreso_diario() -> int:
	var ingreso := 5500
	ingreso += actividad_economica * 220
	ingreso += empleo * 65
	ingreso -= corrupcion * 55
	return max(3500, ingreso)

func calcular_gasto_operativo_diario() -> int:
	var gasto := 12500
	gasto += int((100 - infraestructura) * 20)
	gasto += int(deuda_municipal * 0.0009)
	return gasto

func _aplicar_evento_semanal() -> void:
	# Los eventos con opciones se disparan desde Eventos (autoload)
	# Este método solo lanza la señal; Eventos.gd la recibe y muestra el modal
	var idx := randi_range(0, 5)
	var eventos_node = get_node_or_null("/root/Eventos")
	if eventos_node == null:
		return
	match idx:
		0: eventos_node.evento_semana_floja()
		1: eventos_node.evento_apoyo_estatal()
		2: eventos_node.evento_rumores_corrupcion()
		3: eventos_node.evento_baja_empleo()
		4: eventos_node.evento_quejas_transporte()
		5: eventos_node.evento_actividad_comunitaria()

func _recalcular_aprobacion() -> void:
	var promedio_servicios := int(
		(
			infraestructura +
			seguridad +
			actividad_economica +
			empleo +
			transporte +
			educacion +
			salud +
			tejido_social
		) / 8
	)

	aprobacion_ciudadana = int(
		(aprobacion_ciudadana * 0.78) +
		(promedio_servicios * 0.22) -
		(corrupcion / 18.0) -
		(deuda_municipal / 250000.0)
	)

func _limitar_valores() -> void:
	aprobacion_ciudadana = clamp(aprobacion_ciudadana, 0, 100)
	infraestructura = clamp(infraestructura, 0, 100)
	seguridad = clamp(seguridad, 0, 100)
	actividad_economica = clamp(actividad_economica, 0, 100)
	empleo = clamp(empleo, 0, 100)
	transporte = clamp(transporte, 0, 100)
	educacion = clamp(educacion, 0, 100)
	salud = clamp(salud, 0, 100)
	tejido_social = clamp(tejido_social, 0, 100)
	corrupcion = clamp(corrupcion, 0, 100)
