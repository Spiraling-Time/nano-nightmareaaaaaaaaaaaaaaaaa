extends "res://Game_Stuff/Code/part.gd"




func _ready() -> void:
	own_checker = $Area2D
	custom_size_x = 0
	custom_size_y = 0

	custom_offset = Vector2.ZERO

	custom_speed = 0
	custom_dir
		
	the_parent = self
	type_of_part = "custom"
	max_number_of_bots = 50 
	
	await get_tree().process_frame
	spawn_bots(max_number_of_bots)
