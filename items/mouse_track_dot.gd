extends Node2D

var target_player = null
var disabed = true
var move_range_radius = 100

var attack_area = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	target_player = get_parent()
	global_position = target_player.position
	attack_area = get_node("AttackArea")

func _process(delta):
	if disabed:
		return
	var mouse_position = get_global_mouse_position()
	var offset = mouse_position - target_player.position
	global_position = target_player.position + offset.clamped(move_range_radius)

func start_movement_choose_track():
	self.show()
	disabed = false

func stop_movement_choose_track():
	disabed = true

func start_attack_choose_track():
	attack_area.start_track()

func stop_attack_choose_track():
	attack_area.stop_track()