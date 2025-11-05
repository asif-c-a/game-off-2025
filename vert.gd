extends CharacterBody2D

var move_direction : Vector2
@export var expansion_speed : float = 1

func _ready() -> void:
	position = Vector2.ZERO
	velocity.x = move_direction.x * expansion_speed
	velocity.y = move_direction.y * expansion_speed

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	move_and_slide()
