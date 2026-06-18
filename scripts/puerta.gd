extends Area2D

# Escena destino y posición donde aparece el jugador en esa escena
@export var escena_destino: String = ""
@export var posicion_llegada: Vector2 = Vector2(320, 400)
@export var etiqueta: String = "Presiona E para entrar"

var _jugador_dentro := false
@onready var _hint: Label = _crear_hint()


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _crear_hint() -> Label:
	var l := Label.new()
	l.text = etiqueta
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.add_theme_font_size_override("font_size", 10)
	l.add_theme_color_override("font_color", Color("#FFFFFF"))
	l.position = Vector2(-80, -24)
	l.size = Vector2(160, 20)
	l.visible = false
	# Se agrega al CanvasLayer del padre si existe, si no directamente aquí
	var ui := get_tree().current_scene.get_node_or_null("UI")
	if ui:
		ui.add_child(l)
		# CanvasLayer no tiene posición 2D, así que usamos la etiqueta fuera
		l.visible = false
		remove_child(l)
		# Re-hacemos: etiqueta como hijo de este nodo para que siga en 2D
		var l2 := Label.new()
		l2.text = etiqueta
		l2.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		l2.add_theme_font_size_override("font_size", 10)
		l2.add_theme_color_override("font_color", Color("#FFFFFF"))
		l2.position = Vector2(-60, -28)
		l2.size = Vector2(120, 20)
		l2.visible = false
		add_child(l2)
		return l2
	add_child(l)
	return l


func _unhandled_key_input(event: InputEvent) -> void:
	if not _jugador_dentro:
		return
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_E:
			_ir_a_destino()
			get_viewport().set_input_as_handled()


func _ir_a_destino() -> void:
	if escena_destino == "":
		return
	GameState.posicion_jugador_exterior = posicion_llegada
	if has_node("/root/Transicion"):
		get_node("/root/Transicion").ir_a_escena(escena_destino)
	else:
		get_tree().change_scene_to_file(escena_destino)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_dentro = true
		_hint.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_dentro = false
		_hint.visible = false
