extends Node2D

@export var keyboard_inputs = []
@export var xbox_inputs = []
@export var ps_inputs = []
@export var switch_inputs = []

@export var fixed : bool = false

var controlType : int # Keyboard, XBox, PlayStation, Switch
var currentTutl : int = 0 # Move, Jump, Interact

@onready var tutorialSprite = get_node("Keys")


func _ready() -> void:
	if !fixed:
		position.y = get_parent().get_node("Bot").bottomRightLimit.position.y - 10

func _process(_delta: float) -> void:
	if !fixed:
		var llimit = get_parent().get_node("Bot").topLeftLimit.position.x + 69 
		var rlimit = get_parent().get_node("Bot").bottomRightLimit.position.x - 69
		if get_parent().get_node("Bot").position.x > llimit and get_parent().get_node("Bot").position.x < rlimit:
			position.x = get_parent().get_node("Bot").position.x
	detectController()
	match controlType:
		0:
			tutorialSprite.frame = keyboard_inputs[currentTutl]
		1:
			tutorialSprite.frame = xbox_inputs[currentTutl]
		2:
			tutorialSprite.frame = ps_inputs[currentTutl]
		3:
			tutorialSprite.frame = switch_inputs[currentTutl]

func detectController():
	var controllerIds = Input.get_connected_joypads()
	if controllerIds.size() == 0:
		controlType = 0 
		return
	var jname = Input.get_joy_name(controllerIds[0])
	if "Xbox" in jname:
		controlType = 1
	elif "PlayStation" in jname or "DualShock" in jname or "DualSense" in jname:
		controlType = 2
	elif "Switch" in jname or "Pro Controller" in jname:
		controlType = 3
	else:
		controlType = 1

func _on_movement_body_entered(body: Node2D) -> void:
	if body.name == "Bot":
		currentTutl = 0

func _on_movement_body_exited(body: Node2D) -> void:
	if body.name == "Bot":
		currentTutl = 2
		tutorialSprite.visible = false

func _on_jump_body_entered(body: Node2D) -> void:
	if body.name == "Bot":
		currentTutl = 1
		tutorialSprite.visible = true
	
func _on_jump_body_exited(body: Node2D) -> void:
	if body.name == "Bot":
		currentTutl = 2
		tutorialSprite.visible = false
