extends Node2D

enum TipoEdificio { PRESIDENCIA, MERCADO, PARQUE, SAT, HOSPITAL, BANCO }

@export var tipo: TipoEdificio = TipoEdificio.PRESIDENCIA
@export var nombre_edificio: String = "Edificio"

var player_nearby: bool = false
var panel_open: bool = false

@onready var interaction_label: Label  = get_tree().current_scene.find_child("InteractionLabel", true, false)
@onready var government_panel: Panel   = get_tree().current_scene.find_child("GovernmentPanel", true, false)
@onready var info_label: Label         = get_tree().current_scene.find_child("GovernmentInfoLabel", true, false)
@onready var preview_label: Label      = get_tree().current_scene.find_child("ActionPreviewLabel", true, false)

# Todos los botones posibles — se muestran u ocultan según el tipo
@onready var btn_calles:    Button = get_tree().current_scene.find_child("RepairRoadsButton", true, false)
@onready var btn_seguridad: Button = get_tree().current_scene.find_child("SecurityButton", true, false)
@onready var btn_negocios:  Button = get_tree().current_scene.find_child("BusinessSupportButton", true, false)
@onready var btn_educacion: Button = get_tree().current_scene.find_child("EducationButton", true, false)
@onready var btn_salud:     Button = get_tree().current_scene.find_child("HealthButton", true, false)
@onready var btn_parque:    Button = get_tree().current_scene.find_child("ParkMaintenanceButton", true, false)
@onready var btn_auditoria: Button = get_tree().current_scene.find_child("AuditButton", true, false)
@onready var btn_transporte:Button = get_tree().current_scene.find_child("TransportButton", true, false)
@onready var btn_loan1:     Button = get_tree().current_scene.find_child("LoanMinorButton", true, false)
@onready var btn_loan2:     Button = get_tree().current_scene.find_child("LoanObraButton", true, false)
@onready var btn_dia:       Button = get_tree().current_scene.find_child("AdvanceDayButton", true, false)
@onready var btn_sat1:      Button = get_tree().current_scene.find_child("SatFiscalizacionButton", true, false)
@onready var btn_sat2:      Button = get_tree().current_scene.find_child("SatTramitesButton", true, false)
@onready var btn_sat3:      Button = get_tree().current_scene.find_child("SatAmnistiaButton", true, false)
@onready var btn_hosp1:     Button = get_tree().current_scene.find_child("HospMedicosButton", true, false)
@onready var btn_hosp2:     Button = get_tree().current_scene.find_child("HospMedicamentosButton", true, false)
@onready var btn_hosp3:     Button = get_tree().current_scene.find_child("HospCampanaButton", true, false)

# Qué botones son visibles por tipo de edificio
const _VISIBLES := {
	TipoEdificio.PRESIDENCIA: ["calles","seguridad","negocios","educacion","auditoria","transporte","loan1","loan2","dia"],
	TipoEdificio.MERCADO:     ["negocios","transporte","loan1","dia"],
	TipoEdificio.PARQUE:      ["parque","auditoria","dia"],
	TipoEdificio.SAT:         ["sat1","sat2","sat3","dia"],
	TipoEdificio.HOSPITAL:    ["salud","hosp1","hosp2","hosp3","dia"],
	TipoEdificio.BANCO:       ["loan1","loan2","dia"],
}

func _ready() -> void:
	$InteractionArea.body_entered.connect(_on_body_entered)
	$InteractionArea.body_exited.connect(_on_body_exited)
	_conectar_botones()
	if interaction_label: interaction_label.visible = false
	if government_panel:  government_panel.visible  = false
	_limpiar_preview()


func _conectar_botones() -> void:
	_cb(btn_calles,    GameState.reparar_calles,           "Reparar calles\nCosto: $50,000\n+8 infraestructura · +3 aprobación · +2 economía")
	_cb(btn_seguridad, GameState.mejorar_seguridad,        "Mejorar seguridad\nCosto: $40,000\n+7 seguridad · +2 aprobación")
	_cb(btn_negocios,  GameState.apoyar_negocios,          "Apoyar negocios\nCosto: $30,000\n+7 economía · +1 aprobación · +2 empleo")
	_cb(btn_educacion, GameState.mejorar_educacion,        "Mejorar educación\nCosto: $45,000\n+8 educación · +3 aprobación · +1 economía")
	_cb(btn_salud,     GameState.mejorar_salud,            "Mejorar salud\nCosto: $45,000\n+8 salud · +3 aprobación · +1 seguridad")
	_cb(btn_parque,    GameState.mantener_parque,          "Mantener parque\nCosto: $22,000\n+6 tejido social · +2 seguridad · +1 aprobación")
	_cb(btn_auditoria, GameState.auditoria_publica,        "Auditoría pública\nCosto: $25,000\n-6 corrupción · +2 aprobación")
	_cb(btn_transporte,GameState.mejorar_transporte,       "Mejorar transporte\nCosto: $55,000\n+8 transporte · +3 empleo · +2 economía")
	_cb(btn_loan1,     GameState.solicitar_prestamo_menor, "Préstamo menor\n+$100,000 en caja · Deuda: +$115,000 · -1 aprobación")
	_cb(btn_loan2,     GameState.solicitar_prestamo_obra,  "Préstamo de obra\n+$250,000 en caja · Deuda: +$315,000 · -3 aprobación")
	_cb(btn_sat1,      GameState.sat_fiscalizacion,        "Fiscalización intensiva\nInversión: $20,000 · Recaudación: +$45,000\n-4 corrupción · -2 economía")
	_cb(btn_sat2,      GameState.sat_simplificar_tramites, "Simplificar trámites\nCosto: $15,000\n+5 economía · +2 empleo · +2 aprobación")
	_cb(btn_sat3,      GameState.sat_amnistia_fiscal,      "Amnistía fiscal\nCosto: $10,000 · Recaudación: +$80,000\n+3 aprobación · +2 corrupción")
	_cb(btn_hosp1,     GameState.hospital_contratar_medicos,   "Contratar médicos\nCosto: $60,000\n+12 salud · +3 empleo · +4 aprobación")
	_cb(btn_hosp2,     GameState.hospital_comprar_medicamentos,"Comprar medicamentos\nCosto: $25,000\n+6 salud · +2 aprobación")
	_cb(btn_hosp3,     GameState.hospital_campana_salud,       "Campaña de salud\nCosto: $18,000\n+5 salud · +3 tejido social · +3 aprobación")
	if btn_dia:
		btn_dia.pressed.connect(func(): GameState.avanzar_dia(); _actualizar_panel())
		btn_dia.mouse_entered.connect(func(): _set_preview("Avanzar día\nAplica ingresos, gastos, intereses y posibles eventos semanales."))
		btn_dia.mouse_exited.connect(_limpiar_preview)


func _cb(btn: Button, accion: Callable, preview: String) -> void:
	if btn == null:
		return
	btn.pressed.connect(func(): accion.call(); _actualizar_panel())
	btn.mouse_entered.connect(func(): _set_preview(preview))
	btn.mouse_exited.connect(_limpiar_preview)


func _process(_delta: float) -> void:
	z_index = int(global_position.y)
	if player_nearby and Input.is_action_just_pressed("interact"):
		panel_open = !panel_open
		if government_panel:
			government_panel.visible = panel_open
		if panel_open:
			_configurar_botones_visibles()
			_actualizar_panel()
			if interaction_label: interaction_label.visible = false
		else:
			_mostrar_hint()


func _configurar_botones_visibles() -> void:
	var visibles: Array = _VISIBLES.get(tipo, [])
	var todos := {
		"calles": btn_calles,    "seguridad": btn_seguridad, "negocios": btn_negocios,
		"educacion": btn_educacion, "salud": btn_salud,      "parque": btn_parque,
		"auditoria": btn_auditoria,"transporte": btn_transporte,
		"loan1": btn_loan1,      "loan2": btn_loan2,         "dia": btn_dia,
		"sat1": btn_sat1,        "sat2": btn_sat2,           "sat3": btn_sat3,
		"hosp1": btn_hosp1,      "hosp2": btn_hosp2,         "hosp3": btn_hosp3,
	}
	for clave in todos:
		var b: Button = todos[clave]
		if b != null:
			b.visible = clave in visibles


func _actualizar_panel() -> void:
	if info_label == null:
		return
	var gs := GameState
	var ing := gs.calcular_ingreso_diario()
	var gas := gs.calcular_gasto_operativo_diario()
	info_label.text = (
		"Gobierno de " + gs.municipio_nombre + "\n\n" +
		"Día: " + str(gs.dia_actual) + " / 365\n" +
		"Presupuesto: $" + str(gs.presupuesto_municipal) + "\n" +
		"Deuda: $"        + str(gs.deuda_municipal)       + "\n" +
		"Ingreso diario: $" + str(ing) + "  ·  Gasto: $" + str(gas) + "\n\n" +
		"Aprobación: "    + str(gs.aprobacion_ciudadana)  + "%\n" +
		"Infraestructura: " + str(gs.infraestructura)     + "\n" +
		"Seguridad: "     + str(gs.seguridad)             + "\n" +
		"Economía: "      + str(gs.actividad_economica)   + "\n" +
		"Empleo: "        + str(gs.empleo)                + "\n" +
		"Transporte: "    + str(gs.transporte)            + "\n" +
		"Educación: "     + str(gs.educacion)             + "\n" +
		"Salud: "         + str(gs.salud)                 + "\n" +
		"Tejido social: " + str(gs.tejido_social)         + "\n" +
		"Corrupción: "    + str(gs.corrupcion)
	)
	_actualizar_estados_botones()


func _actualizar_estados_botones() -> void:
	var p := GameState.presupuesto_municipal
	_dis(btn_calles,    p < 50000)
	_dis(btn_seguridad, p < 40000)
	_dis(btn_negocios,  p < 30000)
	_dis(btn_educacion, p < 45000)
	_dis(btn_salud,     p < 45000)
	_dis(btn_parque,    p < 22000)
	_dis(btn_auditoria, p < 25000)
	_dis(btn_transporte,p < 55000)
	_dis(btn_sat1,      p < 20000)
	_dis(btn_sat2,      p < 15000)
	_dis(btn_sat3,      p < 10000)
	_dis(btn_hosp1,     p < 60000)
	_dis(btn_hosp2,     p < 25000)
	_dis(btn_hosp3,     p < 18000)


func _dis(b: Button, d: bool) -> void:
	if b != null: b.disabled = d


func _set_preview(txt: String) -> void:
	if preview_label: preview_label.text = txt

func _limpiar_preview() -> void:
	if preview_label: preview_label.text = "Pasa el mouse sobre una acción para ver costo y beneficios."

func _mostrar_hint() -> void:
	if interaction_label:
		interaction_label.text = nombre_edificio + "\nPresiona E para interactuar"
		interaction_label.visible = true


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = true
		if not panel_open:
			_mostrar_hint()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		panel_open    = false
		if interaction_label: interaction_label.visible = false
		if government_panel:  government_panel.visible  = false


# ── Sprite isométrico dibujado en código ──────────────────────────────────────
# Cada edificio se dibuja como un bloque isométrico:
# base (rombo en el suelo) + cara izquierda + cara derecha + techo

func _draw() -> void:
	match tipo:
		TipoEdificio.PRESIDENCIA: _draw_iso_presidencia()
		TipoEdificio.MERCADO:     _draw_iso_mercado()
		TipoEdificio.PARQUE:      _draw_iso_parque()
		TipoEdificio.SAT:         _draw_iso_sat()
		TipoEdificio.HOSPITAL:    _draw_iso_hospital()
		TipoEdificio.BANCO:       _draw_iso_banco()
	if tipo != TipoEdificio.PRESIDENCIA:
		var font := ThemeDB.fallback_font
		draw_string(font, Vector2(-60, 32), nombre_edificio,
			HORIZONTAL_ALIGNMENT_LEFT, 120, 9, Color("#F5F0E8"))


# Dibuja un bloque isométrico genérico dado colores de techo, cara izq y cara der
# h = altura del bloque en píxeles de pantalla
func _bloque_iso(h: float, c_techo: String, c_izq: String, c_der: String) -> void:
	var hw := 32.0  # mitad del ancho del tile (TILE_W/2)
	var hh := 16.0  # mitad del alto del tile  (TILE_H/2)

	# Techo (rombo superior)
	var techo := PackedVector2Array([
		Vector2(0,   -h - hh),
		Vector2(hw,  -h),
		Vector2(0,   -h + hh),
		Vector2(-hw, -h),
	])
	# Cara izquierda
	var izq := PackedVector2Array([
		Vector2(-hw, -h),
		Vector2(0,   -h + hh),
		Vector2(0,   hh),
		Vector2(-hw, 0),
	])
	# Cara derecha
	var der := PackedVector2Array([
		Vector2(0,   -h + hh),
		Vector2(hw,  -h),
		Vector2(hw,  0),
		Vector2(0,   hh),
	])
	draw_colored_polygon(izq,   Color(c_izq))
	draw_colored_polygon(der,   Color(c_der))
	draw_colored_polygon(techo, Color(c_techo))


func _draw_iso_presidencia() -> void:
	var hw := 44.0
	var hh := 22.0
	var h  := 52.0

	# === ESCALINATA ===
	for i in range(3):
		var o := float(i) * 4.0
		draw_colored_polygon(PackedVector2Array([
			Vector2(-hw*0.7 + o, o + 2),
			Vector2(0 + o*0.3,   o + hh*0.5 + 2),
			Vector2(0 + o*0.3+4, o + hh*0.5 + 4),
			Vector2(-hw*0.7 + o+4, o + 4),
		]), Color("#D4C8A8"))

	# === CUERPO PRINCIPAL ===
	draw_colored_polygon(PackedVector2Array([
		Vector2(-hw, -h), Vector2(0, -h+hh), Vector2(0, hh), Vector2(-hw, 0)
	]), Color("#D4C8A8"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, -h+hh), Vector2(hw, -h), Vector2(hw, 0), Vector2(0, hh)
	]), Color("#B8A99A"))

	# === TECHO TERRACOTA ===
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, -h-hh), Vector2(hw, -h), Vector2(0, -h+hh), Vector2(-hw, -h)
	]), Color("#C4573A"))
	for i in range(1, 5):
		var t := float(i) / 5.0
		draw_line(Vector2(-hw*t, -h - hh*(1.0-t)), Vector2(hw*(1.0-t), -h - hh*(1.0-t) + hh),
			Color("#8B3A2A"), 1.0)

	# === CORNISA ===
	draw_colored_polygon(PackedVector2Array([
		Vector2(-hw, -h+2), Vector2(0, -h+hh+2), Vector2(0, -h+hh+5), Vector2(-hw, -h+5)
	]), Color("#E8DCC4"))
	draw_colored_polygon(PackedVector2Array([
		Vector2(0, -h+hh+2), Vector2(hw, -h+2), Vector2(hw, -h+5), Vector2(0, -h+hh+5)
	]), Color("#D4C8A8"))

	# === ARCOS FACHADA (cara izquierda) ===
	for i in range(3):
		var t  := float(i) / 2.0
		var ax := -hw + 8 + t * (hw - 10)
		var ay := (-h + hh) * (1.0 - t*0.15) - 10
		draw_colored_polygon(PackedVector2Array([
			Vector2(ax, ay), Vector2(ax+6, ay-2),
			Vector2(ax+6, ay+12), Vector2(ax, ay+14),
		]), Color("#5C3A2A"))

	# === VENTANAS CARA DERECHA ===
	for i in range(3):
		var t  := float(i) / 2.0
		var wx := t * (hw - 10)
		var wy := (-h + hh) * (1.0 - t*0.1) - 8
		draw_colored_polygon(PackedVector2Array([
			Vector2(wx, wy), Vector2(wx+8, wy-3),
			Vector2(wx+8, wy+6), Vector2(wx, wy+9),
		]), Color("#4A5F7A"))

	# === TORRES ESQUINERAS ===
	_mini_cupula(Vector2(-hw,      -h      ), 7.0, 14.0)
	_mini_cupula(Vector2( hw,      -h      ), 7.0, 14.0)
	_mini_cupula(Vector2(-hw*0.45, -h-hh*0.4), 6.0, 12.0)
	_mini_cupula(Vector2( hw*0.45, -h-hh*0.4), 6.0, 12.0)

	# === CÚPULA CENTRAL ===
	_cupula_central(Vector2(0.0, -h - hh), 16.0, 32.0)

	# === FAROLES ===
	_farol(Vector2(-hw*0.8, 4.0))
	_farol(Vector2(-hw*0.2, hh*0.4 + 4.0))

	# === LETRERO ===
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(-38, -h*0.2), "PRESIDENCIA",
		HORIZONTAL_ALIGNMENT_LEFT, 76, 7, Color("#F5EDD9"))


func _cupula_central(centro: Vector2, radio: float, altura: float) -> void:
	# Cuerpo de la cúpula como polígono semielíptico
	var pts := PackedVector2Array()
	var steps := 10
	for i in range(steps + 1):
		var t := float(i) / float(steps)
		var angle := PI * t
		pts.append(Vector2(centro.x + cos(angle) * radio, centro.y - sin(angle) * altura))
	draw_colored_polygon(pts, Color("#C4573A"))
	# Sombra lateral
	var sombra := PackedVector2Array()
	for i in range(steps / 2 + 1):
		var t := float(i) / float(steps / 2)
		var angle := PI * 0.5 * t
		sombra.append(Vector2(centro.x + cos(angle) * radio, centro.y - sin(angle) * altura))
	sombra.append(Vector2(centro.x, centro.y))
	draw_colored_polygon(sombra, Color("#8B3A2A"))
	# Linterna encima
	draw_rect(Rect2(centro.x - 4, centro.y - altura - 10, 8, 10), Color("#8B3A2A"))
	draw_line(Vector2(centro.x, centro.y - altura - 10),
			  Vector2(centro.x, centro.y - altura - 18), Color("#2B2B2B"), 1.5)
	draw_rect(Rect2(centro.x - 3, centro.y - altura - 19, 6, 3), Color("#C4573A"))


func _mini_cupula(centro: Vector2, radio: float, altura: float) -> void:
	var pts := PackedVector2Array()
	var steps := 8
	for i in range(steps + 1):
		var t := float(i) / float(steps)
		var angle := PI * t
		pts.append(Vector2(centro.x + cos(angle) * radio, centro.y - sin(angle) * altura))
	draw_colored_polygon(pts, Color("#8B3A2A"))
	# Base de la torreta
	draw_rect(Rect2(centro.x - radio, centro.y - 6, radio * 2, 6), Color("#D4C8A8"))
	# Remate
	draw_line(Vector2(centro.x, centro.y - altura),
			  Vector2(centro.x, centro.y - altura - 6), Color("#2B2B2B"), 1.0)


func _farol(pos: Vector2) -> void:
	draw_line(Vector2(pos.x, pos.y), Vector2(pos.x, pos.y - 14), Color("#2B2B2B"), 1.5)
	draw_circle(Vector2(pos.x, pos.y - 15), 3.0, Color("#F39C12"))


func _draw_iso_mercado() -> void:
	_bloque_iso(32.0, "#E67E22", "#CA6F1E", "#D68910")
	# Toldo
	var toldo := PackedVector2Array([
		Vector2(0, -32-16), Vector2(32, -32), Vector2(0, -32+16), Vector2(-32, -32)
	])
	draw_colored_polygon(toldo, Color("#C0392B"))


func _draw_iso_parque() -> void:
	# Base verde (más baja)
	_bloque_iso(8.0, "#27AE60", "#1E8449", "#229954")
	# Árbol izquierdo
	draw_circle(Vector2(-16, -20), 10.0, Color("#1E8449"))
	draw_line(Vector2(-16, -10), Vector2(-16, -4), Color("#8B4513"), 2.0)
	# Árbol derecho
	draw_circle(Vector2(16, -20), 10.0, Color("#27AE60"))
	draw_line(Vector2(16, -10), Vector2(16, -4), Color("#8B4513"), 2.0)


func _draw_iso_sat() -> void:
	_bloque_iso(36.0, "#2C2C2C", "#1A1A1A", "#242424")
	# Franja roja en cara izquierda
	var franja := PackedVector2Array([
		Vector2(-32, -12), Vector2(0, -12+16), Vector2(0, -8+16), Vector2(-32, -8)
	])
	draw_colored_polygon(franja, Color("#E74C3C"))
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(-14, -38), "SAT", HORIZONTAL_ALIGNMENT_LEFT, 36, 8, Color("#E74C3C"))


func _draw_iso_hospital() -> void:
	_bloque_iso(36.0, "#ECF0F1", "#BDC3C7", "#D5D8DC")
	# Cruz roja en techo
	draw_rect(Rect2(-3, -36-16-4, 6, 18), Color("#E74C3C"))
	draw_rect(Rect2(-9, -36-16+3, 18, 6), Color("#E74C3C"))


func _draw_iso_banco() -> void:
	_bloque_iso(38.0, "#3498DB", "#1A5276", "#2471A3")
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(-8, -42), "$", HORIZONTAL_ALIGNMENT_LEFT, 20, 18, Color("#F39C12"))
