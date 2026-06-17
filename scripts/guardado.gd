extends Node

const RUTA := "user://partida.json"

func guardar() -> void:
	var gs := GameState
	var datos := {
		"municipio_nombre":      gs.municipio_nombre,
		"dia_actual":            gs.dia_actual,
		"presupuesto_municipal": gs.presupuesto_municipal,
		"deuda_municipal":       gs.deuda_municipal,
		"aprobacion_ciudadana":  gs.aprobacion_ciudadana,
		"infraestructura":       gs.infraestructura,
		"seguridad":             gs.seguridad,
		"actividad_economica":   gs.actividad_economica,
		"empleo":                gs.empleo,
		"transporte":            gs.transporte,
		"educacion":             gs.educacion,
		"salud":                 gs.salud,
		"tejido_social":         gs.tejido_social,
		"corrupcion":            gs.corrupcion,
	}
	var f := FileAccess.open(RUTA, FileAccess.WRITE)
	f.store_string(JSON.stringify(datos, "\t"))
	f.close()
	print("Partida guardada.")


func cargar() -> bool:
	if not FileAccess.file_exists(RUTA):
		return false
	var f := FileAccess.open(RUTA, FileAccess.READ)
	var parsed = JSON.parse_string(f.get_as_text())
	f.close()
	if parsed == null:
		return false
	var gs := GameState
	gs.municipio_nombre      = parsed.get("municipio_nombre",      gs.municipio_nombre)
	gs.dia_actual            = parsed.get("dia_actual",            gs.dia_actual)
	gs.presupuesto_municipal = parsed.get("presupuesto_municipal", gs.presupuesto_municipal)
	gs.deuda_municipal       = parsed.get("deuda_municipal",       gs.deuda_municipal)
	gs.aprobacion_ciudadana  = parsed.get("aprobacion_ciudadana",  gs.aprobacion_ciudadana)
	gs.infraestructura       = parsed.get("infraestructura",       gs.infraestructura)
	gs.seguridad             = parsed.get("seguridad",             gs.seguridad)
	gs.actividad_economica   = parsed.get("actividad_economica",   gs.actividad_economica)
	gs.empleo                = parsed.get("empleo",                gs.empleo)
	gs.transporte            = parsed.get("transporte",            gs.transporte)
	gs.educacion             = parsed.get("educacion",             gs.educacion)
	gs.salud                 = parsed.get("salud",                 gs.salud)
	gs.tejido_social         = parsed.get("tejido_social",         gs.tejido_social)
	gs.corrupcion            = parsed.get("corrupcion",            gs.corrupcion)
	print("Partida cargada — Día " + str(gs.dia_actual))
	return true


func hay_partida() -> bool:
	return FileAccess.file_exists(RUTA)
