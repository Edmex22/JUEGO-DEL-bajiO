extends CharacterBody2D

@export var speed: float = 120.0

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Convertir input cartesiano a dirección isométrica
	var iso := Vector2(
		(input_vector.x - input_vector.y),
		(input_vector.x + input_vector.y) * 0.5
	).normalized() * input_vector.length()

	velocity = iso * speed
	move_and_slide()

	# Depth sorting: los nodos con mayor Y se dibujan encima
	z_index = int(position.y)
