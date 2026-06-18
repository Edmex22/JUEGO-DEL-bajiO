extends CanvasLayer

@onready var barra_top: RichTextLabel   = $BarraTop/MarginContainer/HBox/TopLabel
@onready var panel_stats: Panel       = $PanelStats
@onready var stats_label: RichTextLabel = $PanelStats/MarginContainer/StatsLabel
@onready var btn_toggle: Button       = $BarraTop/BtnStats

var _panel_abierto := false


func _ready() -> void:
	btn_toggle.pressed.connect(_toggle_panel)
	panel_stats.visible = false


func _process(_delta: float) -> void:
	_actualizar_top()
	if _panel_abierto:
		_actualizar_stats()


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_TAB:
			_toggle_panel()
			get_viewport().set_input_as_handled()


func _toggle_panel() -> void:
	_panel_abierto = !_panel_abierto
	panel_stats.visible = _panel_abierto
	btn_toggle.text = "📊 Cerrar" if _panel_abierto else "📊 Stats"


func _actualizar_top() -> void:
	var gs := GameState
	var color_presup := "#2ECC71" if gs.presupuesto_municipal > 100000 else "#E74C3C"
	barra_top.text = (
		"[b]" + gs.municipio_nombre + "[/b]" +
		"   📅 Día " + str(gs.dia_actual) + "/365" +
		"   💰 [color=" + color_presup + "]$" + _fmt(gs.presupuesto_municipal) + "[/color]" +
		"   🏦 Deuda: [color=#E74C3C]$" + _fmt(gs.deuda_municipal) + "[/color]" +
		"   ⭐ Aprob: [color=#F39C12]" + str(gs.aprobacion_ciudadana) + "%[/color]"
	)


func _actualizar_stats() -> void:
	var gs := GameState
	var ing := gs.calcular_ingreso_diario()
	var gas := gs.calcular_gasto_operativo_diario()
	var balance_color := "#2ECC71" if ing >= gas else "#E74C3C"

	stats_label.text = (
		"[b]Indicadores del Municipio[/b]   [color=#888888][Tab] para cerrar[/color]\n\n" +
		"[color=#AAAAAA]Ingreso diario: [color=#2ECC71]$" + _fmt(ing) +
		"[/color]   Gasto: [color=#E74C3C]$" + _fmt(gas) +
		"[/color]   Balance: [color=" + balance_color + "]$" + _fmt(ing - gas) + "[/color][/color]\n\n" +
		_fila("🏗  Infraestructura", gs.infraestructura,     "#9B59B6") +
		_fila("🛡  Seguridad",       gs.seguridad,           "#546E7A") +
		_fila("💼  Economía",        gs.actividad_economica, "#E67E22") +
		_fila("👷  Empleo",          gs.empleo,              "#16A085") +
		_fila("🚌  Transporte",      gs.transporte,          "#3498DB") +
		_fila("📚  Educación",       gs.educacion,           "#F39C12") +
		_fila("🏥  Salud",           gs.salud,               "#27AE60") +
		_fila("🤝  Tejido social",   gs.tejido_social,       "#8E44AD") +
		_fila("🚨  Corrupción",      gs.corrupcion,          "#C0392B", true)
	)


func _fila(nombre: String, valor: int, color: String, inverso: bool = false) -> String:
	var llenos := int(valor * 15 / 100.0)
	var barra := "[color=" + color + "]" + "█".repeat(llenos) + "[/color][color=#333333]" + "█".repeat(15 - llenos) + "[/color]"
	var alerta := ""
	if (not inverso and valor <= 35) or (inverso and valor >= 65):
		alerta = " [color=#E74C3C]⚠[/color]"
	return "%-20s %s  [b]%3d[/b]%s\n" % [nombre, barra, valor, alerta]


func _fmt(n: int) -> String:
	if abs(n) >= 1000000:
		return "%.1fM" % (n / 1000000.0)
	if abs(n) >= 1000:
		return "%.1fk" % (n / 1000.0)
	return str(n)
