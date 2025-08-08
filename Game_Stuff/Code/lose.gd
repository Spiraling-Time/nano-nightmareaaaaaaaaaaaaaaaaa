extends Node2D

var save_path_score = "user://variable.score"
var score = 0

func _ready() -> void:
	load_data_score()
	$Label.text = "%d" % score




func load_data_score():
	if FileAccess.file_exists(save_path_score):
		var file = FileAccess.open(save_path_score, FileAccess.READ)
		score = file.get_var()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_Stuff/Scenes/main_menu.tscn")
