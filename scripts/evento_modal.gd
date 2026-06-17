extends Panel

@onready var titulo_label: Label       = $MarginContainer/VBox/Titulo
@onready var desc_label: Label         = $MarginContainer/VBox/Descripcion
@onready var botones_container: VBoxContainer = $MarginContainer/VBox/Botones

var _opciones: Array = []


func mostrar(titulo: String, descripcion: String, opciones: Array) -> void:
	_opciones = opciones
	titulo_label.text = titulo
	desc_label.text   = descripcion

	for b in botones_container.get_children():
		b.queue_free()

	for i in opciones.size():
		var btn := Button.new()
		btn.text = opciones[i].texto
		btn.custom_minimum_size = Vector2(0, 44)
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		btn.pressed.connect(_elegir.bind(i))
		botones_container.add_child(btn)

	visible = true
	get_tree().paused = true


func _elegir(idx: int) -> void:
	_opciones[idx].efecto.call()
	get_tree().paused = false
	visible = false
