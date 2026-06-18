extends CharacterBody2D

@export var nombre_npc: String = "Ciudadano"
@export var rol: String = ""
@export var dialogos: Array[String] = ["Hola."]
# Diálogos extra que se desbloquean según estado del juego
@export var dialogos_noche: Array[String] = []
@export var dialogos_bajo_presupuesto: Array[String] = []

@onready var _etiqueta: Label = _crear_etiqueta()

var _jugador_cerca := false
var _area: Area2D


func _ready() -> void:
	_area = _crear_area()
	_area.body_entered.connect(_on_body_entered)
	_area.body_exited.connect(_on_body_exited)
	_crear_sprite_npc()


func _crear_etiqueta() -> Label:
	var l := Label.new()
	l.text = nombre_npc if rol == "" else nombre_npc + "\n[" + rol + "]"
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.add_theme_font_size_override("font_size", 8)
	l.add_theme_color_override("font_color", Color("#FFE080"))
	l.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 0.8))
	l.add_theme_constant_override("shadow_offset_x", 1)
	l.add_theme_constant_override("shadow_offset_y", 1)
	l.position = Vector2(-40, -38)
	l.size = Vector2(80, 24)
	l.visible = false
	add_child(l)
	return l


func _crear_area() -> Area2D:
	var a := Area2D.new()
	var s := CollisionShape2D.new()
	var r := CircleShape2D.new()
	r.radius = 40.0
	s.shape = r
	a.add_child(s)
	add_child(a)
	return a


func _crear_sprite_npc() -> void:
	# Sprite simple de persona (círculo cabeza + rectángulo cuerpo)
	var n := Node2D.new()
	var script_sprite := load("res://scripts/npc_sprite.gd")
	if script_sprite:
		n.set_script(script_sprite)
	add_child(n)


func _get_dialogos_actuales() -> Array[String]:
	# Elige diálogos según estado del juego
	if dialogos_bajo_presupuesto.size() > 0 and GameState.presupuesto_municipal < 50000:
		return dialogos_bajo_presupuesto
	if dialogos_noche.size() > 0:
		var fase := (GameState.dia_actual - 1) % 7
		if fase == 4 or fase == 5:
			return dialogos_noche
	return dialogos


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_E and _jugador_cerca:
			var lineas := _get_dialogos_actuales()
			if has_node("/root/Dialogo"):
				get_node("/root/Dialogo").mostrar(nombre_npc, lineas)
			get_viewport().set_input_as_handled()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_cerca = true
		_etiqueta.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_cerca = false
		_etiqueta.visible = false
