extends KinematicBody2D

class_name Player

signal start_move()

export (int) var speed = 200000

var destination_position = Vector2()
var min_moving_step = 10

var during_turn = false

onready var mouse_track_dot = get_node("MouseTrackDot")
onready var walking_area = get_node("WalkingArea")

func _ready():
	destination_position = position

func _input(e):
	if during_turn and e.is_action_pressed('left_click'):
		destination_position = get_global_mouse_position()
		emit_signal("start_move")

func move():
	yield(self, 'start_move')
	position = mouse_track_dot.global_position

func play_turn():
	yield(choose_movement(), "completed")

func choose_movement():
	yield(get_tree().create_timer(0.1), "timeout")
	during_turn = true
	mouse_track_dot.start_track()
	walking_area.global_position = global_position
	walking_area.show()
	yield(self.move(), 'completed')
	walking_area.hide()
	mouse_track_dot.stop_track()
	during_turn = false	