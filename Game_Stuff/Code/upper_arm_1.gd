extends "res://Game_Stuff/Code/part.gd"



func _ready() -> void:
	the_parent = $"../../.."
	type_of_part = "upper_arm1"
	max_number_of_bots = 50 
	
	await get_tree().process_frame
	spawn_bots(max_number_of_bots)
