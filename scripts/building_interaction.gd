extends Sprite2D

var player_nearby: bool = false
var panel_open: bool = false

@onready var interaction_label: Label = get_tree().current_scene.find_child("InteractionLabel", true, false) as Label
@onready var government_panel: Panel = get_tree().current_scene.find_child("GovernmentPanel", true, false) as Panel
@onready var government_info_label: Label = get_tree().current_scene.find_child("GovernmentInfoLabel", true, false) as Label
@onready var action_preview_label: Label = get_tree().current_scene.find_child("ActionPreviewLabel", true, false) as Label

@onready var repair_roads_button: Button = get_tree().current_scene.find_child("RepairRoadsButton", true, false) as Button
@onready var security_button: Button = get_tree().current_scene.find_child("SecurityButton", true, false) as Button
@onready var business_support_button: Button = get_tree().current_scene.find_child("BusinessSupportButton", true, false) as Button
@onready var education_button: Button = get_tree().current_scene.find_child("EducationButton", true, false) as Button
@onready var health_button: Button = get_tree().current_scene.find_child("HealthButton", true, false) as Button
@onready var advance_day_button: Button = get_tree().current_scene.find_child("AdvanceDayButton", true, false) as Button

@onready var park_maintenance_button: Button = get_tree().current_scene.find_child("ParkMaintenanceButton", true, false) as Button
@onready var audit_button: Button = get_tree().current_scene.find_child("AuditButton", true, false) as Button
@onready var transport_button: Button = get_tree().current_scene.find_child("TransportButton", true, false) as Button


func _ready() -> void:
	$InteractionArea.body_entered.connect(_on_body_entered)
	$InteractionArea.body_exited.connect(_on_body_exited)

	_connect_button(repair_roads_button, _on_repair_roads_pressed, _preview_repair_roads)
	_connect_button(security_button, _on_security_pressed, _preview_security)
	_connect_button(business_support_button, _on_business_support_pressed, _preview_business_support)
	_connect_button(education_button, _on_education_pressed, _preview_education)
	_connect_button(health_button, _on_health_pressed, _preview_health)
	_connect_button(advance_day_button, _on_advance_day_pressed, _preview_advance_day)

	_connect_button(park_maintenance_button, _on_park_maintenance_pressed, _preview_park_maintenance)
	_connect_button(audit_button, _on_audit_pressed, _preview_audit)
	_connect_button(transport_button, _on_transport_pressed, _preview_transport)

	interaction_label.visible = false
	government_panel.visible = false
	_clear_preview()


func _connect_button(button: Button, pressed_callable: Callable, preview_callable: Callable) -> void:
	if button == null:
		return

	button.pressed.connect(pressed_callable)
	button.mouse_entered.connect(preview_callable)
	button.mouse_exited.connect(_clear_preview)


func _process(_delta: float) -> void:
	if player_nearby and Input.is_action_just_pressed("interact"):
		panel_open = !panel_open
		government_panel.visible = panel_open

		if panel_open:
			_update_government_panel()
			interaction_label.visible = false
			print("Panel de gobierno abierto")
		else:
			interaction_label.text = "Presidencia Municipal\nPresiona E para interactuar"
			interaction_label.visible = true
			print("Panel de gobierno cerrado")


func _update_government_panel() -> void:
	var ingreso_diario: int = GameState.calcular_ingreso_diario()
	var gasto_diario: int = GameState.calcular_gasto_operativo_diario()

	government_info_label.text = (
		"Gobierno Municipal de " + GameState.municipio_nombre + "\n\n" +
		"Día: " + str(GameState.dia_actual) + " / 365\n\n" +
		"Presupuesto: " + _money(GameState.presupuesto_municipal) + "\n" +
		"Deuda municipal: " + _money(GameState.deuda_municipal) + "\n" +
		"Ingreso diario estimado: " + _money(ingreso_diario) + "\n" +
		"Gasto operativo diario: " + _money(gasto_diario) + "\n\n" +
		"Aprobación ciudadana: " + str(GameState.aprobacion_ciudadana) + "%\n" +
		"Infraestructura: " + str(GameState.infraestructura) + "/100\n" +
		"Seguridad: " + str(GameState.seguridad) + "/100\n" +
		"Economía: " + str(GameState.actividad_economica) + "/100\n" +
		"Empleo: " + str(GameState.empleo) + "/100\n" +
		"Transporte: " + str(GameState.transporte) + "/100\n" +
		"Educación: " + str(GameState.educacion) + "/100\n" +
		"Salud: " + str(GameState.salud) + "/100\n" +
		"Tejido social: " + str(GameState.tejido_social) + "/100\n" +
		"Corrupción: " + str(GameState.corrupcion) + "/100"
	)

	_update_button_states()


func _update_button_states() -> void:
	_set_button_disabled(repair_roads_button, GameState.presupuesto_municipal < 50000)
	_set_button_disabled(security_button, GameState.presupuesto_municipal < 40000)
	_set_button_disabled(business_support_button, GameState.presupuesto_municipal < 30000)
	_set_button_disabled(education_button, GameState.presupuesto_municipal < 45000)
	_set_button_disabled(health_button, GameState.presupuesto_municipal < 45000)
	_set_button_disabled(park_maintenance_button, GameState.presupuesto_municipal < 22000)
	_set_button_disabled(audit_button, GameState.presupuesto_municipal < 25000)
	_set_button_disabled(transport_button, GameState.presupuesto_municipal < 55000)
	_set_button_disabled(advance_day_button, false)


func _set_button_disabled(button: Button, disabled_value: bool) -> void:
	if button != null:
		button.disabled = disabled_value


func _money(value: int) -> String:
	return "$" + str(value)


func _set_preview(text: String) -> void:
	action_preview_label.text = text


func _clear_preview() -> void:
	action_preview_label.text = "Pasa el mouse sobre una acción para ver costo y beneficios."


func _preview_repair_roads() -> void:
	_set_preview(
		"Reparar calles\n" +
		"Costo: $50,000\n" +
		"Beneficios: +8 infraestructura, +3 aprobación, +2 economía"
	)


func _preview_security() -> void:
	_set_preview(
		"Mejorar seguridad\n" +
		"Costo: $40,000\n" +
		"Beneficios: +7 seguridad, +2 aprobación"
	)


func _preview_business_support() -> void:
	_set_preview(
		"Apoyar negocios\n" +
		"Costo: $30,000\n" +
		"Beneficios: +7 economía, +1 aprobación, +2 empleo"
	)


func _preview_education() -> void:
	_set_preview(
		"Mejorar educación\n" +
		"Costo: $45,000\n" +
		"Beneficios: +8 educación, +3 aprobación, +1 economía"
	)


func _preview_health() -> void:
	_set_preview(
		"Mejorar salud\n" +
		"Costo: $45,000\n" +
		"Beneficios: +8 salud, +3 aprobación, +1 seguridad"
	)


func _preview_park_maintenance() -> void:
	_set_preview(
		"Mantener parque\n" +
		"Costo: $22,000\n" +
		"Beneficios: +6 tejido social, +2 seguridad, +1 aprobación"
	)


func _preview_audit() -> void:
	_set_preview(
		"Auditoría pública\n" +
		"Costo: $25,000\n" +
		"Beneficios: -6 corrupción, +2 aprobación"
	)


func _preview_transport() -> void:
	_set_preview(
		"Mejorar transporte\n" +
		"Costo: $55,000\n" +
		"Beneficios: +8 transporte, +3 empleo, +2 economía"
	)


func _preview_advance_day() -> void:
	_set_preview(
		"Avanzar día\n" +
		"Aplica ingresos diarios, gastos operativos, intereses de deuda y posibles eventos semanales."
	)


func _on_repair_roads_pressed() -> void:
	GameState.reparar_calles()
	_update_government_panel()


func _on_security_pressed() -> void:
	GameState.mejorar_seguridad()
	_update_government_panel()


func _on_business_support_pressed() -> void:
	GameState.apoyar_negocios()
	_update_government_panel()


func _on_education_pressed() -> void:
	GameState.mejorar_educacion()
	_update_government_panel()


func _on_health_pressed() -> void:
	GameState.mejorar_salud()
	_update_government_panel()


func _on_park_maintenance_pressed() -> void:
	GameState.mantener_parque()
	_update_government_panel()


func _on_audit_pressed() -> void:
	GameState.auditoria_publica()
	_update_government_panel()


func _on_transport_pressed() -> void:
	GameState.mejorar_transporte()
	_update_government_panel()


func _on_advance_day_pressed() -> void:
	GameState.avanzar_dia()
	_update_government_panel()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = true

		if not panel_open:
			interaction_label.text = "Presidencia Municipal\nPresiona E para interactuar"
			interaction_label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		panel_open = false
		interaction_label.visible = false
		government_panel.visible = false
