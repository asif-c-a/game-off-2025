extends StaticBody2D

@export var received_input : int # eg. 01001
var open_door : bool = false

func read_input():
	var input_string = str(received_input)
	for i in input_string:
		use_code(i)

func use_code(code):
	if code == 0:
		open_door = false
	else:
		open_door = true
