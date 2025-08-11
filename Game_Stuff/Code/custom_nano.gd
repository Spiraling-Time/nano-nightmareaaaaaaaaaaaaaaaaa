extends "res://Game_Stuff/Code/part.gd"



func _ready() -> void:
	own_checker = $Area2D


		
	the_parent = self
	type_of_part = "custom"
	
	await get_tree().process_frame
	spawn_bots(max_number_of_bots)

func _physics_process(delta: float) -> void:
	if custom_active:
		if type_of_movement == "Steady":
			if position.y <= 1720.0 and position.y >= -1640.0 and position.x >= -4848.0 and position.x <= 4848.0: position += custom_speed * custom_dir
			else: type_of_movement = "Return"
		if type_of_movement == "Return":
			position -= custom_speed * custom_dir
			type_of_movement = "Idle"
func _on_timer_timeout() -> void:
	custom_active = true
