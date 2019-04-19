extends YSort

class_name TurnQueue

var active_character : Player

func _ready():
	active_character = get_child(0)
	play_turn()

func play_turn():
	yield(active_character.play_turn(), "completed")
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	play_turn()
