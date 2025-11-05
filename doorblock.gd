extends StaticBody2D

var door_open_speed : float = 10
var open_door : bool = false

@onready var door_segment1 = get_node("Door_Segment")
@onready var door_segment2 = get_node("Door_Segment/Door_Segment2")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and !open_door:
		open_door = true
	elif Input.is_action_just_pressed("interact") and open_door:
		open_door = false
	
	if open_door:
		openDoor(delta)
	else:
		closeDoor(delta)

func openDoor(dt):
	door_segment1.position.y = lerp(door_segment1.position.y, 0.0, door_open_speed * dt)
	await get_tree().create_timer(1).timeout
	if open_door:
		door_segment2.position.y = lerp(door_segment2.position.y, 0.0, door_open_speed * dt)

func closeDoor(dt):
	door_segment2.position.y = lerp(door_segment2.position.y, 4.0, door_open_speed * dt)
	await get_tree().create_timer(1).timeout
	if !open_door:
		door_segment1.position.y = lerp(door_segment1.position.y, 4.0, door_open_speed * dt)
