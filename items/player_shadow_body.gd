extends Node2D

var target_player = null
var movement_choose_track_disabed = true
var move_range_radius = 100

var attack_area = null

signal attack_chosen()
var attack_direction = null
var attack_choose_track_disabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	target_player = get_parent()
	global_position = target_player.position
	attack_area = get_node("AttackArea")

func _process(delta):
	if movement_choose_track_disabed:
		return
	var mouse_position = get_global_mouse_position()
	var offset = mouse_position - target_player.position
	global_position = target_player.position + offset.clamped(move_range_radius)

func track_movement_choose():
	movement_choose_track_disabed = false
	self.show()
	yield()
	movement_choose_track_disabed = true

func track_attack_choose():
	attack_choose_track_disabled = false
	var circle_sector_update_action = attack_area.track_attack_direction()
	yield(self, 'attack_chosen')
	circle_sector_update_action.resume()
	self.hide()
	attack_choose_track_disabled = true

func _input(e):
	if attack_choose_track_disabled:
		return
	if e.is_action_pressed('left_click'):
		if e.position.x > self.global_position.x:
			attack_direction = "attack_right"
		else:
			attack_direction = "attack_left"
		emit_signal("attack_chosen")