extends KinematicBody2D

export (int) var speed = 200000

var destination_position = Vector2()
var min_moving_step = 10

func _ready():
	destination_position = position

func _physics_process(delta):
	move(destination_position)

func _input(e):
	if e.is_action_pressed('left_click'):
		destination_position = get_global_mouse_position()

func move(to_position):
	move_and_slide(to_position - position)
#	position.x = to_position.x
#	position.y = to_position.y
