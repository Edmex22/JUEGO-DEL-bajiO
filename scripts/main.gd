extends Node2D

@onready var eventos: Node  = $Eventos
@onready var modal: Panel   = $UI/EventoModal


func _ready() -> void:
	eventos.evento_disparado.connect(_on_evento)
	# Configurar tipo e nombre de cada edificio
	_init_edificio($PresidenciaMunicipal, 0, "Presidencia Municipal")
	_init_edificio($MercadoMunicipal,     1, "Mercado Municipal")
	_init_edificio($ParqueCentral,        2, "Parque Central")
	_init_edificio($OficinasSAT,          3, "Oficinas del SAT")
	_init_edificio($Hospital,             4, "Hospital General")
	_init_edificio($Banco,                5, "Banco Municipal")


func _init_edificio(nodo: Sprite2D, tipo: int, nombre: String) -> void:
	if nodo == null:
		return
	nodo.tipo = tipo
	nodo.nombre_edificio = nombre


func _on_evento(titulo: String, descripcion: String, opciones: Array) -> void:
	modal.mostrar(titulo, descripcion, opciones)
