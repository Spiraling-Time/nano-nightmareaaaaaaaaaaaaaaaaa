extends "res://Game_Stuff/Code/part.gd"

func _ready() -> void:
	type_of_part = "head"
	max_number_of_bots = 250 
	
	await get_tree().process_frame
	#print(max_number_of_bots)
	spawn_bots(max_number_of_bots)
