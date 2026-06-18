extends CharacterBody2D

@export var nombre_npc: String = "NPC"
@export var dialogos: Array[String] = ["Hola."]

var _jugador_cerca := false
@onready var _area: Area2D = _crear_area()
@onready var _sprite: Node2D = _crear_sprite()


func _ready() -> void:
	_area.body_entered.connect(_on_body_entered)
	_area.body_exited.connect(_on_body_exited)


func _crear_area() -> Area2D:
	var a := Area2D.new()
	var s := CollisionShape2D.new()
	var r := CircleShape2D.new()
	r.radius = 48.0
	s.shape = r
	a.add_child(s)
	add_child(a)
	return a


func _crear_sprite() -> Node2D:
	var n := Node2D.new()
	n.set_script(load("res://scripts/player_sprite.gd"))
	add_child(n)
	return n


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_E and _jugador_cerca:
			if Dialogo:
				Dialogo.mostrar(nombre_npc, dialogos)
			get_viewport().set_input_as_handled()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_cerca = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_jugador_cerca = false
