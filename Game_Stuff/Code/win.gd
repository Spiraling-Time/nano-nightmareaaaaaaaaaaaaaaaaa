extends Node2D


func _on_timer_timeout() -> void:
	if $Sprite2D.frame < 7: $Sprite2D.frame += 1


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_Stuff/Scenes/main_menu.tscn")
