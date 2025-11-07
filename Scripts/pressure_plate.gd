extends StaticBody2D

var pressured : bool = false
@onready var plate = get_node("Plate")
@export var plate_move_speed : float

@export var emmision_radius : float = 100.0
var emitter = preload("res://Scenes/Misc/code_emitter.tscn")
var expansion_speed : float = 50.0

@export var trigger_delay : float = 0.125

var hack_blocks = []

func _physics_process(delta: float) -> void:
	if pressured:
		pressure(delta)
	else:
		releived(delta)

@warning_ignore("unused_parameter")
func do(s):
	pass

func pressure(dt):
	plate.position.y = lerp(plate.position.y, 0.5, plate_move_speed * dt)

func releived(dt):
	plate.position.y = lerp(plate.position.y, 0.0, plate_move_speed * dt)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		pressured = true
		
		await get_tree().create_timer(trigger_delay).timeout
		
		var em = emitter.instantiate()
		add_child(em)
		var deathTime = emmision_radius / expansion_speed
		
		hack_blocks = get_parent().get_children()
		for i in hack_blocks:
			print(i.name)
			if i is StaticBody2D and i.position.distance_to(position) <= emmision_radius and i != self:
				i.do(i.position.distance_to(position) / expansion_speed)
		
		await get_tree().create_timer(deathTime).timeout
		em.destroy()

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		pressured = false
