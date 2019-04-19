extends KinematicBody2D

class_name Player

signal start_move()

export (int) var speed = 200000

var destination_position = Vector2()
var min_moving_step = 10

var during_turn = false

func _ready():
	destination_position = position

func _input(e):
	if during_turn and e.is_action_pressed('left_click'):
		destination_position = get_global_mouse_position()
		emit_signal("start_move")

func move():
	yield(self, 'start_move')
	position.x = destination_position.x
	position.y = destination_position.y

func play_turn():
	yield(get_tree().create_timer(0.1), "timeout")
	during_turn = true
	yield(self.move(), 'completed')
	during_turn = false