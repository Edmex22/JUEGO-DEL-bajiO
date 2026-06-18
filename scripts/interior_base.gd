extends Node2D

@export var escena_exterior: String = "res://main.tscn"
@export var posicion_salida: Vector2 = Vector2.ZERO

@onready var zona_salida: Area2D = $ZonaSalida
@onready var label_salida: Label = get_node_or_null("UI/LabelSalida")

var _jugador_en_salida := false


func _ready() -> void:
	zona_salida.body_entered.connect(_on_salida_entered)
	zona_salida.body_exited.connect(_on_salida_exited)
	_dibujar_interior()
	# Fade in al llegar
	if Transicion:
		Transicion.fade_in()


func _dibujar_interior() -> void:
	# Piso de baldosas beige
	var fondo := ColorRect.new()
	fondo.color = Color("#C8A96E")
	fondo.size = Vector2(640, 480)
	fondo.position = Vector2.ZERO
	$Fondo.add_child(fondo)

	# Paredes laterales
	var pared_izq := ColorRect.new()
	pared_izq.color = Color("#F5E6C8")
	pared_izq.size = Vector2(32, 480)
	pared_izq.position = Vector2(0, 0)
	$Fondo.add_child(pared_izq)

	var pared_der := ColorRect.new()
	pared_der.color = Color("#F5E6C8")
	pared_der.size = Vector2(32, 480)
	pared_der.position = Vector2(608, 0)
	$Fondo.add_child(pared_der)

	var pared_arr := ColorRect.new()
	pared_arr.color = Color("#8B6914")
	pared_arr.size = Vector2(640, 48)
	pared_arr.position = Vector2(0, 0)
	$Fondo.add_child(pared_arr)

	# Mesas de trabajo
	_mesa(Vector2(100, 200))
	_mesa(Vector2(440, 200))
	_mesa(Vector2(100, 340))
	_mesa(Vector2(440, 340))

	# Bandera de México (decorativa)
	var bandera := ColorRect.new()
	bandera.color = Color("#006847")
	bandera.size = Vector2(10, 30)
	bandera.position = Vector2(308, 80)
	$Fondo.add_child(bandera)

	var b2 := ColorRect.new()
	b2.color = Color("#CE1126")
	b2.size = Vector2(10, 30)
	b2.position = Vector2(318, 80)
	$Fondo.add_child(b2)

	# Texto de título
	var titulo := Label.new()
	titulo.text = "PRESIDENCIA MUNICIPAL"
	titulo.position = Vector2(160, 55)
	titulo.add_theme_color_override("font_color", Color("#FFD700"))
	$Fondo.add_child(titulo)

	# Puerta de salida (sur)
	var puerta := ColorRect.new()
	puerta.color = Color("#6B3A2A")
	puerta.size = Vector2(80, 16)
	puerta.position = Vector2(280, 528)
	$Fondo.add_child(puerta)


func _mesa(pos: Vector2) -> void:
	var m := ColorRect.new()
	m.color = Color("#8B4513")
	m.size = Vector2(80, 48)
	m.position = pos
	$Fondo.add_child(m)

	var papel := ColorRect.new()
	papel.color = Color("#FFFDF0")
	papel.size = Vector2(40, 28)
	papel.position = pos + Vector2(20, 10)
	$Fondo.add_child(papel)


func _on_salida_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_en_salida = true
		if label_salida:
			label_salida.visible = true


func _on_salida_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_en_salida = false
		if label_salida:
			label_salida.visible = false


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_E and _jugador_en_salida:
			GameState.posicion_jugador_exterior = posicion_salida
			Transicion.ir_a_escena(escena_exterior)
