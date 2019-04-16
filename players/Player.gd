extends KinematicBody2D

export (int) var speed = 200000

var destination_position = Vector2()
var min_moving_step = 10

func _physics_process(delta):
	move(destination_position)

func _input(e):
	if (e is InputEventMouseButton and e.button_index == BUTTON_LEFT and not e.pressed):
		destination_position = get_global_mouse_position()

func move(to_position):
	position.x = to_position.x
	position.y = to_position.y
