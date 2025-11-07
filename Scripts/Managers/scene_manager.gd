extends Node

@export var scenes = [
	preload("res://Levels/level_1.tscn"),
	preload("res://Levels/level_2.tscn"),
	preload("res://Levels/level_3.tscn")
]

var curr_scene = 1

func nextScene():
	if curr_scene + 1 <= len(scenes):
		curr_scene += 1
		get_tree().change_scene_to_packed(scenes[curr_scene - 1])
	else:
		get_tree().quit()
