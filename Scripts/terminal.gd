extends Node2D

@export var emmision_radius : float = 100.0
var playerIn : bool = false
var interactionEntity
var emitter = preload("res://Scenes/Misc/code_emitter.tscn")
var expansion_speed : float = 50.0

var hack_blocks = []

@onready var grandParent = get_parent().get_parent()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and playerIn:
		var em = emitter.instantiate()
		add_child(em)
		var deathTime = emmision_radius / expansion_speed
		
		hack_blocks = get_parent().get_children()
		for i in hack_blocks:
			print(i.name)
			if i is StaticBody2D and i.position.distance_to(position) <= emmision_radius:
				i.do(i.position.distance_to(position) / expansion_speed)
		
		BotMovement.read_input = false
		await get_tree().create_timer(deathTime).timeout
		BotMovement.read_input = true
		em.destroy()
	
	if playerIn:
		$Sprite2D.frame_coords.y = 1
	else:
		$Sprite2D.frame_coords.y = 0

func _on_player_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Bot":
		interactionEntity = body
		playerIn = true
		grandParent.get_node("Tutorial").currentTutl = 2
		grandParent.get_node("Tutorial").tutorialSprite.visible = true

func _on_player_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Bot":
		interactionEntity = body
		playerIn = false
		grandParent.get_node("Tutorial").tutorialSprite.visible = false
