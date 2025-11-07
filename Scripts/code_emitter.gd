extends Node2D

@export var vertices : int
var vert_prefab = preload("res://Scenes/Misc/vert.tscn")
@onready var line = get_node("Line2D")
var die : bool = false
signal dead

func _ready() -> void:
	reset()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	updateLine()
	
	if die:
		modulate.a = lerp(modulate.a, 0.0, 10 * delta)
	if modulate.a <= 0:
		dead.emit()

func reset():
	makeVertices()
	drawLine()
	for i in range(vertices):
		var vert = get_node(str(i+1))
		vert.position = Vector2.ZERO

func makeVertices():
	for i in range(vertices):
		var vert = vert_prefab.instantiate()
		var angle = (2 * PI)/vertices * i
		var dir = Vector2(cos(angle), sin(angle))
		vert.move_direction = dir
		vert.name = str(i + 1)
		add_child(vert)

func drawLine():
	for i in range(vertices):
		var vert = get_node(str(i+1))
		line.add_point(vert.position)

func updateLine():
	for i in range(vertices):
		var vert = get_node(str(i+1))
		line.set_point_position(i, vert.position)

func destroy():
	die = true
	await dead
	queue_free()
