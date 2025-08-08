extends "res://Game_Stuff/Code/part.gd"

func _ready() -> void:
	the_parent = $"../../.."
	type_of_part = "upper_leg2"
	max_number_of_bots = 50 
	
	await get_tree().process_frame
	spawn_bots(max_number_of_bots)


func _on_respawn_nanobots_timeout() -> void:
	if max_number_of_bots - number_of_bots >= 0:
		spawn_bots(1)
