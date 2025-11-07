extends CharacterBody2D

var move_direction : Vector2
@export var expansion_speed : float = 1
var speed : float

func _ready() -> void:
	position = Vector2.ZERO
	speed = expansion_speed

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	velocity.x = move_direction.x * speed
	velocity.y = move_direction.y * speed
	
	move_and_slide()
