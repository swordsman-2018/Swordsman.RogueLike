extends KinematicBody2D

class_name Player

signal start_move()
signal attack_chosen()

export (int) var speed = 200000

var destination_position = Vector2()
var min_moving_step = 10

var during_turn = false

onready var mouse_track_dot = get_node("MouseTrackDot")
onready var walking_area = get_node("WalkingArea")

# Suspend -> Started -> MovementChosen -> AttatckChosen -> Suspend
var turn_state = "Suspend"

func _ready():
	destination_position = position
	$bodyArea.connect("body_entered", self, "hurt")

func hurt(object):
	if object.name == "swordBody":
		print("hurt")

func _input(e):
	if during_turn:
		if turn_state == "Started" and e.is_action_pressed('left_click'):
			destination_position = get_global_mouse_position()
			emit_signal("start_move")
		if turn_state == "MovementChosen" and e.is_action_pressed('left_click'):
			emit_signal("attack_chosen")

func move():
	yield(self, 'start_move')
	position = mouse_track_dot.global_position

func choose_attack():
	yield(self, 'attack_chosen')
	get_node("AnimationPlayer").play("leftAttack")

func play_turn():
	during_turn = true
	turn_state = "Started"
	
	yield(movement_turn(), "completed")
	yield(attack_turn(), "completed")
	
	during_turn = false

func movement_turn():
	yield(get_tree().create_timer(0.1), "timeout")
	
	mouse_track_dot.start_track()
	walking_area.global_position = global_position
	walking_area.show()
	yield(self.move(), 'completed')
	walking_area.hide()
	mouse_track_dot.stop_track()
	
	turn_state = "MovementChosen"

func attack_turn():
	yield(get_tree().create_timer(0.5), "timeout")
	
	yield(choose_attack(), 'completed')
	
	turn_state = "AttackChosen"
