extends KinematicBody2D

class_name Player

signal start_move()
signal attack_chosen()

export (int) var speed = 200000

var destination_position = Vector2()
var min_moving_step = 10

var during_turn = false

onready var player_shadow_body = get_node("PlayerShadowBody")
onready var walking_area = get_node("WalkingArea")

# Suspend -> Started -> MovementChosen -> AttatckChosen -> Suspend
var turn_state = "Suspend"

var attack_direction

func _ready():
	destination_position = position
	$bodyArea.connect("body_entered", self, "hurt")

func hurt(object):
	if object.name == "swordBody":
		print("hurt")

func attack_prepare():
	during_turn = true
	turn_state = "Started"
	
	yield(self.movement_turn(), "completed")
	yield(self.attack_turn(), "completed")
	
	during_turn = false

func attack_move():
	yield(get_tree().create_timer(0.01), "timeout")
	move()

func attack_action():
	yield(get_tree().create_timer(0.01), "timeout")
	attack()

func movement_turn():
	yield(get_tree().create_timer(0.1), "timeout")
	
	var movement_choose_track = player_shadow_body.track_movement_choose()
	
	walking_area.global_position = global_position
	walking_area.show()
	yield(self.choose_movement(), 'completed')
	walking_area.hide()
	
	movement_choose_track.resume()
	
	turn_state = "MovementChosen"

func attack_turn():
	yield(get_tree().create_timer(0.5), "timeout")
	
	var track_action = player_shadow_body.track_attack_choose()
	
	yield(choose_attack(), 'completed')

	track_action.resume()
	
	turn_state = "AttackChosen"

func choose_movement():
	yield(self, 'start_move')

func choose_attack():
	yield(self, 'attack_chosen')

func _input(e):
	if during_turn:
		if turn_state == "Started" and e.is_action_pressed('left_click'):
			destination_position = get_global_mouse_position()
			emit_signal("start_move")
		if turn_state == "MovementChosen" and e.is_action_pressed('left_click'):
			if e.position.x > self.position.x:
				attack_direction = "attack_right"
			else:
				attack_direction = "attack_left"
			emit_signal("attack_chosen")

func move():
	position = player_shadow_body.global_position

func attack():
	if attack_direction == "attack_left":
		get_node("AnimationPlayer").play("leftAttack")
	else:
		get_node("AnimationPlayer").play("rightAttack")



