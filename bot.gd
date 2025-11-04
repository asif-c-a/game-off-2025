extends CharacterBody2D

@export var gravity : float = 900.0
@export var acceleration : float = 600.0
@export var max_speed : float = 200.0
@export var friction : float = 1000.0

var dir = 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	inputs()
	calcvel(delta)
	move_and_slide()
	bodyRot()
	headRot(delta)

func inputs():
	dir = 0
	if Input.is_action_pressed("left"):
		dir -= 1
	if Input.is_action_pressed("right"):
		dir += 1

func calcvel(delta):
	if dir != 0:
		if sign(velocity.x) != 0 and sign(velocity.x) != dir:
			velocity.x -= sign(velocity.x) * friction * delta
			if sign(velocity.x) != sign(velocity.x - sign(velocity.x) * friction * delta):
				velocity.x = 0
		else:
			velocity.x += acceleration * dir * delta
			velocity.x = clamp(velocity.x, -max_speed, max_speed)
	else:
		if abs(velocity.x) < friction * delta:
			velocity.x = 0
		else:
			velocity.x -= sign(velocity.x) * friction * delta

func bodyRot():
	if velocity.x > 0:
		$Body.rotation_degrees += velocity.x / 5
	elif velocity.x < 0:
		$Body.rotation_degrees += velocity.x / 5
	else:
		$Body.rotation_degrees += 0

func headRot(dt):
	if velocity.x > 0:
		$HeadMarker.rotation_degrees = lerp($HeadMarker.rotation_degrees, 30.00, 5 * dt)
	elif velocity.x < 0:
		$HeadMarker.rotation_degrees = lerp($HeadMarker.rotation_degrees, -30.00, 5 * dt)
	else:
		$HeadMarker.rotation_degrees = lerp($HeadMarker.rotation_degrees, 0.00, 10 * dt)
