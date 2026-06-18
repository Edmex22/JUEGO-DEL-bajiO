extends Node2D

@onready var eventos: Node  = $Eventos
@onready var modal: Panel   = $UI/EventoModal


func _ready() -> void:
	eventos.evento_disparado.connect(_on_evento)
	_init_edificio($PresidenciaMunicipal, 0, "Presidencia Municipal")
	_init_edificio($MercadoMunicipal,     1, "Mercado Municipal")
	_init_edificio($ParqueCentral,        2, "Parque Central")
	_init_edificio($OficinasSAT,          3, "Oficinas del SAT")
	_init_edificio($Hospital,             4, "Hospital General")
	_init_edificio($Banco,                5, "Banco Municipal")

	# Reposicionar jugador si viene de un interior
	var jugador := $Player
	if jugador and GameState.posicion_jugador_exterior != Vector2.ZERO:
		jugador.position = GameState.posicion_jugador_exterior

	# Fade in al cargar la escena principal
	if has_node("/root/Transicion"):
		get_node("/root/Transicion").fade_in()


func _init_edificio(nodo: Node2D, tipo: int, nombre: String) -> void:
	if nodo == null:
		return
	nodo.tipo = tipo
	nodo.nombre_edificio = nombre


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.physical_keycode:
			KEY_F5:
				Guardado.guardar()
			KEY_F6:
				Guardado.cargar()


func _on_evento(titulo: String, descripcion: String, opciones: Array) -> void:
	modal.mostrar(titulo, descripcion, opciones)
