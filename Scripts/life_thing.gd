extends StaticBody2D

var loc : float = 0

func _physics_process(delta: float) -> void:
	$LifeSprite.position.y = lerp($LifeSprite.position.y, loc, 2 * delta)
	
	if $LifeSprite.position.y >= -0.1:
		loc = -1
	elif $LifeSprite.position.y <= -0.8:
		loc = 0
