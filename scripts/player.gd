extends CharacterBody2D

const SPEED = 300.0

@onready var screen_size = get_viewport_rect().size

func _physics_process(_delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	move_and_slide()
