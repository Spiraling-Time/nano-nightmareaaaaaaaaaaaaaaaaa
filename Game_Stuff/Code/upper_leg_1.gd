extends "res://Game_Stuff/Code/part.gd"

func _ready() -> void:
	type_of_part = "upper_leg1"
	max_number_of_bots = 50 
	
	await get_tree().process_frame
	spawn_bots(max_number_of_bots)
