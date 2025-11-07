extends StaticBody2D

var elevator_speed : float = 10
var elevator_work : bool = false

@onready var elevator_platform = get_node("Platform")

func _process(delta: float) -> void:
	if elevator_work:
		elevate(delta)
	else:
		delevate(delta)

func do(s):
	await get_tree().create_timer(s).timeout
	elevator_work = !elevator_work

func elevate(dt):
	if elevator_platform.position.y > -24:
		elevator_platform.position.y = lerp(elevator_platform.position.y, elevator_platform.position.y - 1, elevator_speed * dt)
	else:
		elevator_platform.position.y = -24

func delevate(dt):
	if elevator_platform.position.y < 0:
		elevator_platform.position.y = lerp(elevator_platform.position.y, elevator_platform.position.y + 1, elevator_speed * dt)
	else:
		elevator_platform.position.y = 0
