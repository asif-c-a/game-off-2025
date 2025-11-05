extends StaticBody2D

var piston_push_speed : float = 10
var push_piston : bool = false

@onready var piston_head = get_node("PistonHead")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and !push_piston:
		push_piston = true
	elif Input.is_action_just_pressed("interact") and push_piston:
		push_piston = false
	
	if push_piston:
		pushPiston(delta)
	else:
		pullPiston(delta)

func pushPiston(dt):
	piston_head.position.y = lerp(piston_head.position.y, -4.0, piston_push_speed * dt)

func pullPiston(dt):
	piston_head.position.y = lerp(piston_head.position.y, 0.0, piston_push_speed * dt)
