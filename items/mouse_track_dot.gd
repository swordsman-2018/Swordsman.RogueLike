extends Node2D

var target_player = null
var disabed = true
var move_range_radius = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	target_player = get_parent()
	global_position = target_player.position

func _process(delta):
	if disabed:
		return
	var mouse_position = get_global_mouse_position()
	var offset = mouse_position - target_player.position
	global_position = target_player.position + offset.clamped(move_range_radius)

func start_track():
	self.show()
	disabed = false

func stop_track():
	disabed = true
#	self.hide()