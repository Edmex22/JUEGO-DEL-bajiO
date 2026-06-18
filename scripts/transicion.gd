extends CanvasLayer

signal fade_completo

const DURACION := 0.5

@onready var rect: ColorRect = $FadeRect

var _activo := false


func _ready() -> void:
	rect.color = Color(0, 0, 0, 0)
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func fade_out() -> void:
	if _activo:
		return
	_activo = true
	rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tw := create_tween()
	tw.tween_property(rect, "color", Color(0, 0, 0, 1), DURACION)
	await tw.finished
	emit_signal("fade_completo")


func fade_in() -> void:
	var tw := create_tween()
	tw.tween_property(rect, "color", Color(0, 0, 0, 0), DURACION)
	await tw.finished
	_activo = false
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func ir_a_escena(ruta: String) -> void:
	await fade_out()
	get_tree().change_scene_to_file(ruta)
