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


# ── Sprite pixel-art dibujado en código ───────────────────────────────────────
func _draw() -> void:
	match tipo:
		TipoEdificio.PRESIDENCIA: _draw_presidencia()
		TipoEdificio.MERCADO:     _draw_mercado()
		TipoEdificio.PARQUE:      _draw_parque()
		TipoEdificio.SAT:         _draw_sat()
		TipoEdificio.HOSPITAL:    _draw_hospital()
		TipoEdificio.BANCO:       _draw_banco()
	# Nombre del edificio debajo
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(-40, 54), nombre_edificio,
		HORIZONTAL_ALIGNMENT_LEFT, 80, 10, Color("#F5F0E8"))


func _r(x:float,y:float,w:float,h:float,c:String) -> void:
	draw_rect(Rect2(x, y, w, h), Color(c))


func _draw_presidencia() -> void:
	_r(-44,-40, 88, 80, "#C0392B")   # cuerpo
	_r(-48,-44, 96,  8, "#8B2020")   # techo
	_r(-36,-30, 12, 30, "#8B2020")   # columna izq
	_r( 24,-30, 12, 30, "#8B2020")   # columna der
	_r( -8,-30, 16, 20, "#1A1A1A")   # puerta
	_r(-28,-24, 12, 12, "#F39C12")   # ventana izq
	_r( 16,-24, 12, 12, "#F39C12")   # ventana der
	_r(-20,-52, 40,14, "#E74C3C")    # bandera
	_r(-20,-52,  6, 6, "#2ECC71")


func _draw_mercado() -> void:
	_r(-40,-30, 80, 60, "#E67E22")   # cuerpo naranja
	_r(-44,-36, 88, 10, "#C0392B")   # toldo rojo
	_r(-36,-36, 12, 10, "#E74C3C")   # franja toldo
	_r(  0,-36, 12, 10, "#E74C3C")
	_r(-28,-20, 20, 28, "#1A1A1A")   # puerta
	_r( 10,-20, 20, 16, "#F5F0E8")   # vitrina
	_r(-44, 24, 88,  6, "#8B4513")   # base


func _draw_parque() -> void:
	_r(-44,-10, 88, 40, "#27AE60")   # pasto
	# Árbol izquierdo
	_r(-30,-40, 18, 30, "#1E8449")
	_r(-24,-50, 10, 14, "#27AE60")
	_r(-26,-10,  6, 28, "#8B4513")
	# Árbol derecho
	_r( 12,-40, 18, 30, "#1E8449")
	_r( 16,-50, 10, 14, "#27AE60")
	_r( 20,-10,  6, 28, "#8B4513")
	# Banca
	_r( -8, 10, 16,  4, "#F5F0E8")
	_r( -8, 14,  4,  8, "#888888")
	_r( 10, 14,  4,  8, "#888888")


func _draw_sat() -> void:
	_r(-40,-36, 80, 72, "#2C2C2C")   # cuerpo gris oscuro
	_r(-44,-40, 88,  8, "#1A1A1A")   # techo
	_r(-36,-28, 72,  6, "#E74C3C")   # franja roja
	_r(-10,-30,  20,36, "#1A1A1A")   # puerta
	_r(-32,-18, 16, 14, "#3498DB")   # ventana izq
	_r( 16,-18, 16, 14, "#3498DB")   # ventana der
	# Letrero SAT
	_r(-20,-40, 40, 10, "#E74C3C")
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(-14,-33), "SAT", HORIZONTAL_ALIGNMENT_LEFT, 40, 9, Color("#F5F0E8"))


func _draw_hospital() -> void:
	_r(-40,-36, 80, 72, "#F5F0E8")   # cuerpo blanco hueso
	_r(-44,-40, 88,  8, "#2ECC71")   # techo verde
	_r(-10,-30, 20, 36, "#1A1A1A")   # puerta
	_r(-30,-20, 18, 14, "#3498DB")   # ventana izq
	_r( 12,-20, 18, 14, "#3498DB")   # ventana der
	# Cruz roja
	_r( -5,-38, 10, 28, "#E74C3C")
	_r(-14,-27, 28, 10, "#E74C3C")


func _draw_banco() -> void:
	_r(-40,-36, 80, 72, "#3498DB")   # cuerpo azul
	_r(-44,-40, 88, 10, "#1A4F7A")   # techo
	# Columnas
	for i in range(3):
		_r(-32 + i*22, -30, 10, 50, "#1A4F7A")
	_r(-10,-28, 20, 34, "#1A1A1A")   # puerta
	# Símbolo $
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(-10,-42), "$", HORIZONTAL_ALIGNMENT_LEFT, 24, 22, Color("#F39C12"))
