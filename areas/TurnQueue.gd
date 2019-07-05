extends YSort

class_name TurnQueue

#var active_character : Player

#signal attack_prepared()

func _ready():
#	active_character = get_child(0)
	play_turn()

func play_turn():
#	yield(active_character.play_turn(), "completed")
#	var new_index : int = (active_character.get_index() + 1) % get_child_count()
#	active_character = get_child(new_index)
	var players = get_children()

	for player in players:
		yield(player.attack_prepare(), "completed")

	for player in players:
		yield(player.attack_move(), "completed")

	for player in players:
		yield(player.attack_action(), "completed")

	play_turn()
