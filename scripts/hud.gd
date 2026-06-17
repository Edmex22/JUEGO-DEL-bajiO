extends CanvasLayer

@onready var label: RichTextLabel = $HUDPanel/MarginContainer/HUDLabel


func _process(_delta: float) -> void:
	_actualizar()


func _actualizar() -> void:
	var gs := GameState
	label.text = (
		"[b]" + gs.municipio_nombre + "[/b]   Día " + str(gs.dia_actual) + " / 365\n" +
		"Presupuesto: [color=#2ECC71]$" + str(gs.presupuesto_municipal) + "[/color]" +
		"   Deuda: [color=#E74C3C]$" + str(gs.deuda_municipal) + "[/color]" +
		"   Aprobación: [color=#F39C12]" + str(gs.aprobacion_ciudadana) + "%[/color]\n" +
		_barra("Infraestructura", gs.infraestructura,     "#9B59B6") +
		_barra("Seguridad",       gs.seguridad,           "#2C3E50") +
		_barra("Economía",        gs.actividad_economica, "#E67E22") +
		_barra("Empleo",          gs.empleo,              "#16A085") +
		_barra("Transporte",      gs.transporte,          "#3498DB") +
		_barra("Educación",       gs.educacion,           "#F39C12") +
		_barra("Salud",           gs.salud,               "#2ECC71") +
		_barra("Tejido social",   gs.tejido_social,       "#E74C3C") +
		_barra("Corrupción",      gs.corrupcion,          "#C0392B", true)
	)


func _barra(nombre: String, valor: int, color: String, inverso: bool = false) -> String:
	var bloques_total := 20
	var llenos := int(valor * bloques_total / 100.0)
	var barra := "[color=" + color + "]" + "█".repeat(llenos) + "[/color]" + "░".repeat(bloques_total - llenos)
	var alerta := ""
	if (not inverso and valor <= 35) or (inverso and valor >= 65):
		alerta = " [color=#E74C3C]⚠[/color]"
	return "%-16s %s %3d%s\n" % [nombre, barra, valor, alerta]
