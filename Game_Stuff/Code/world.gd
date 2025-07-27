extends Node2D

func _ready() -> void:
	randomize()

func end_game():
	get_tree().paused = true
	print("Is inside tree?", is_inside_tree())  # Should print true
	get_tree().change_scene_to_file("res://Game_Stuff/Scenes/main_menu.tscn")
	get_tree().paused = false
