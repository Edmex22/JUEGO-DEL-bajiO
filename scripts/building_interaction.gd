extends Sprite2D

# Edificio genérico — configurable desde el Inspector
@export var nombre_edificio: String = "Edificio"
@export var acciones: Array[String] = []

var player_nearby: bool = false
var panel_open: bool = false

@onready var interaction_label: Label = get_tree().current_scene.find_child("InteractionLabel", true, false)
@onready var government_panel: Panel = get_tree().current_scene.find_child("GovernmentPanel", true, false)
@onready var government_info_label: Label = get_tree().current_scene.find_child("GovernmentInfoLabel", true, false)
@onready var action_preview_label: Label = get_tree().current_scene.find_child("ActionPreviewLabel", true, false)

# Botones del panel (se buscan por nombre, los que no existan se ignoran)
@onready var repair_roads_button: Button      = get_tree().current_scene.find_child("RepairRoadsButton", true, false)
@onready var security_button: Button          = get_tree().current_scene.find_child("SecurityButton", true, false)
@onready var business_support_button: Button  = get_tree().current_scene.find_child("BusinessSupportButton", true, false)
@onready var education_button: Button         = get_tree().current_scene.find_child("EducationButton", true, false)
@onready var health_button: Button            = get_tree().current_scene.find_child("HealthButton", true, false)
@onready var advance_day_button: Button       = get_tree().current_scene.find_child("AdvanceDayButton", true, false)
@onready var park_maintenance_button: Button  = get_tree().current_scene.find_child("ParkMaintenanceButton", true, false)
@onready var audit_button: Button             = get_tree().current_scene.find_child("AuditButton", true, false)
@onready var transport_button: Button         = get_tree().current_scene.find_child("TransportButton", true, false)
@onready var loan_minor_button: Button        = get_tree().current_scene.find_child("LoanMinorButton", true, false)
@onready var loan_obra_button: Button         = get_tree().current_scene.find_child("LoanObraButton", true, false)


func _ready() -> void:
	$InteractionArea.body_entered.connect(_on_body_entered)
	$InteractionArea.body_exited.connect(_on_body_exited)

	_connect_button(repair_roads_button,     _on_repair_roads_pressed,    _preview_repair_roads)
	_connect_button(security_button,         _on_security_pressed,        _preview_security)
	_connect_button(business_support_button, _on_business_support_pressed,_preview_business_support)
	_connect_button(education_button,        _on_education_pressed,       _preview_education)
	_connect_button(health_button,           _on_health_pressed,          _preview_health)
	_connect_button(advance_day_button,      _on_advance_day_pressed,     _preview_advance_day)
	_connect_button(park_maintenance_button, _on_park_maintenance_pressed,_preview_park_maintenance)
	_connect_button(audit_button,            _on_audit_pressed,           _preview_audit)
	_connect_button(transport_button,        _on_transport_pressed,       _preview_transport)
	_connect_button(loan_minor_button,       _on_loan_minor_pressed,      _preview_loan_minor)
	_connect_button(loan_obra_button,        _on_loan_obra_pressed,       _preview_loan_obra)

	if interaction_label:
		interaction_label.visible = false
	if government_panel:
		government_panel.visible = false
	_clear_preview()


func _connect_button(button: Button, pressed_fn: Callable, preview_fn: Callable) -> void:
	if button == null:
		return
	button.pressed.connect(pressed_fn)
	button.mouse_entered.connect(preview_fn)
	button.mouse_exited.connect(_clear_preview)


func _process(_delta: float) -> void:
	if player_nearby and Input.is_action_just_pressed("interact"):
		panel_open = !panel_open
		if government_panel:
			government_panel.visible = panel_open
		if panel_open:
			_update_government_panel()
			if interaction_label:
				interaction_label.visible = false
		else:
			_show_hint()


func _update_government_panel() -> void:
	if government_info_label == null:
		return
	var ingreso := GameState.calcular_ingreso_diario()
	var gasto   := GameState.calcular_gasto_operativo_diario()
	government_info_label.text = (
		"Gobierno Municipal de " + GameState.municipio_nombre + "\n\n" +
		"Día: " + str(GameState.dia_actual) + " / 365\n\n" +
		"Presupuesto: "           + _money(GameState.presupuesto_municipal) + "\n" +
		"Deuda municipal: "       + _money(GameState.deuda_municipal)       + "\n" +
		"Ingreso diario est.: "   + _money(ingreso)                         + "\n" +
		"Gasto operativo diario: "+ _money(gasto)                           + "\n\n" +
		"Aprobación ciudadana: "  + str(GameState.aprobacion_ciudadana)     + "%\n" +
		"Infraestructura: "       + str(GameState.infraestructura)          + "/100\n" +
		"Seguridad: "             + str(GameState.seguridad)                + "/100\n" +
		"Economía: "              + str(GameState.actividad_economica)      + "/100\n" +
		"Empleo: "                + str(GameState.empleo)                   + "/100\n" +
		"Transporte: "            + str(GameState.transporte)               + "/100\n" +
		"Educación: "             + str(GameState.educacion)                + "/100\n" +
		"Salud: "                 + str(GameState.salud)                    + "/100\n" +
		"Tejido social: "         + str(GameState.tejido_social)            + "/100\n" +
		"Corrupción: "            + str(GameState.corrupcion)               + "/100"
	)
	_update_button_states()


func _update_button_states() -> void:
	_set_btn(repair_roads_button,     GameState.presupuesto_municipal < 50000)
	_set_btn(security_button,         GameState.presupuesto_municipal < 40000)
	_set_btn(business_support_button, GameState.presupuesto_municipal < 30000)
	_set_btn(education_button,        GameState.presupuesto_municipal < 45000)
	_set_btn(health_button,           GameState.presupuesto_municipal < 45000)
	_set_btn(park_maintenance_button, GameState.presupuesto_municipal < 22000)
	_set_btn(audit_button,            GameState.presupuesto_municipal < 25000)
	_set_btn(transport_button,        GameState.presupuesto_municipal < 55000)
	_set_btn(loan_minor_button,       false)
	_set_btn(loan_obra_button,        false)
	_set_btn(advance_day_button,      false)


func _set_btn(b: Button, dis: bool) -> void:
	if b != null:
		b.disabled = dis


func _money(v: int) -> String:
	return "$" + str(v)


func _show_hint() -> void:
	if interaction_label:
		interaction_label.text = nombre_edificio + "\nPresiona E para interactuar"
		interaction_label.visible = true


func _set_preview(txt: String) -> void:
	if action_preview_label:
		action_preview_label.text = txt


func _clear_preview() -> void:
	if action_preview_label:
		action_preview_label.text = "Pasa el mouse sobre una acción para ver costo y beneficios."


# ── Previews ──────────────────────────────────────────────────────────────────
func _preview_repair_roads()      -> void: _set_preview("Reparar calles\nCosto: $50,000\n+8 infraestructura · +3 aprobación · +2 economía")
func _preview_security()          -> void: _set_preview("Mejorar seguridad\nCosto: $40,000\n+7 seguridad · +2 aprobación")
func _preview_business_support()  -> void: _set_preview("Apoyar negocios\nCosto: $30,000\n+7 economía · +1 aprobación · +2 empleo")
func _preview_education()         -> void: _set_preview("Mejorar educación\nCosto: $45,000\n+8 educación · +3 aprobación · +1 economía")
func _preview_health()            -> void: _set_preview("Mejorar salud\nCosto: $45,000\n+8 salud · +3 aprobación · +1 seguridad")
func _preview_park_maintenance()  -> void: _set_preview("Mantener parque\nCosto: $22,000\n+6 tejido social · +2 seguridad · +1 aprobación")
func _preview_audit()             -> void: _set_preview("Auditoría pública\nCosto: $25,000\n-6 corrupción · +2 aprobación")
func _preview_transport()         -> void: _set_preview("Mejorar transporte\nCosto: $55,000\n+8 transporte · +3 empleo · +2 economía")
func _preview_loan_minor()        -> void: _set_preview("Préstamo menor\nRecibe $100,000 · Deuda: $115,000 · -1 aprobación")
func _preview_loan_obra()         -> void: _set_preview("Préstamo de obra\nRecibe $250,000 · Deuda: $315,000 · -3 aprobación")
func _preview_advance_day()       -> void: _set_preview("Avanzar día\nAplica ingresos, gastos, intereses y posibles eventos semanales.")


# ── Acciones ──────────────────────────────────────────────────────────────────
func _on_repair_roads_pressed()      -> void: GameState.reparar_calles();      _update_government_panel()
func _on_security_pressed()          -> void: GameState.mejorar_seguridad();   _update_government_panel()
func _on_business_support_pressed()  -> void: GameState.apoyar_negocios();     _update_government_panel()
func _on_education_pressed()         -> void: GameState.mejorar_educacion();   _update_government_panel()
func _on_health_pressed()            -> void: GameState.mejorar_salud();       _update_government_panel()
func _on_park_maintenance_pressed()  -> void: GameState.mantener_parque();     _update_government_panel()
func _on_audit_pressed()             -> void: GameState.auditoria_publica();   _update_government_panel()
func _on_transport_pressed()         -> void: GameState.mejorar_transporte();  _update_government_panel()
func _on_loan_minor_pressed()        -> void: GameState.solicitar_prestamo_menor(); _update_government_panel()
func _on_loan_obra_pressed()         -> void: GameState.solicitar_prestamo_obra();  _update_government_panel()
func _on_advance_day_pressed()       -> void: GameState.avanzar_dia();         _update_government_panel()


# ── Área de interacción ───────────────────────────────────────────────────────
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = true
		if not panel_open:
			_show_hint()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		panel_open = false
		if interaction_label:
			interaction_label.visible = false
		if government_panel:
			government_panel.visible = false
