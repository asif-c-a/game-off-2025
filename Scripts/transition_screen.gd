extends CanvasLayer

@onready var screen : ColorRect = get_node("ColorRect")
@onready var anim : AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	anim.play("fade_to_normal")
