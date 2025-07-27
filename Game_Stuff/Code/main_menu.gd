extends Node2D

func _ready() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Game_Stuff/Scenes/world.tscn")
