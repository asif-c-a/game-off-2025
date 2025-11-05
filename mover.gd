extends CharacterBody2D

@export var move_speed : float
@export var gravity : float = 900.0
var dir : int = 1


@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if is_on_wall():
		dir *= -1
		$MoverSprite.flip_h = !$MoverSprite.flip_h
	velocity.x = move_speed * dir
	
	move_and_slide()
