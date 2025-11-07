extends StaticBody2D

var loc : float = 0
var loadingScreen : CanvasLayer

func _ready() -> void:
	loadingScreen = get_parent().get_node("TransitionScreen")
	BotMovement.read_input = true
	if loadingScreen == null:
		printerr("Transition Screen Node not in scene")
	loadingScreen.visible = true

func _physics_process(delta: float) -> void:
	$LifeSprite.position.y = lerp($LifeSprite.position.y, loc, 2 * delta)
	
	if $LifeSprite.position.y >= -0.1:
		loc = -1
	elif $LifeSprite.position.y <= -0.8:
		loc = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Bot":
		BotMovement.read_input = false
		loadingScreen.anim.play("fade_to_black")
		await loadingScreen.anim.animation_finished
		SceneManager.nextScene()
