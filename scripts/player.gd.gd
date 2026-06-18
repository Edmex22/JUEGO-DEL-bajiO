extends CharacterBody2D

@export var speed: float = 120.0

@onready var sprite: Node2D = $PlayerSprite

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var iso := Vector2(
		(input_vector.x - input_vector.y),
		(input_vector.x + input_vector.y) * 0.5
	).normalized() * input_vector.length()

	velocity = iso * speed
	move_and_slide()

	z_index = int(position.y)

	# Actualizar dirección del sprite
	if input_vector.length() > 0.1 and sprite:
		if abs(input_vector.x) > abs(input_vector.y):
			sprite._direccion = "este" if input_vector.x > 0 else "oeste"
		else:
			sprite._direccion = "sur" if input_vector.y > 0 else "norte"
		sprite.queue_redraw()
