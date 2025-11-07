extends StaticBody2D

var piston_push_speed : float = 10
var push_piston : bool = false

@onready var piston_head = get_node("PistonHead")

func _process(delta: float) -> void:
	if push_piston:
		pushPiston(delta)
	else:
		pullPiston(delta)

func do(s):
	await get_tree().create_timer(s).timeout
	push_piston = !push_piston

func pushPiston(dt):
	piston_head.position.y = lerp(piston_head.position.y, -4.0, piston_push_speed * dt)

func pullPiston(dt):
	piston_head.position.y = lerp(piston_head.position.y, 0.0, piston_push_speed * dt)
