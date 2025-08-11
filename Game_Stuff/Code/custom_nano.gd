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
			if position.y <= 1720: position += custom_speed * custom_dir


func _on_timer_timeout() -> void:
	custom_active = true
