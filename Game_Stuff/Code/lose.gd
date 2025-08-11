extends Node2D

var save_path_high_score = "user://variable.high_score"
var high_score = 0

var save_path_score = "user://variable.score"
var score = 0

func _ready() -> void:
	load_data_score()
	$Label.text = "%d" % score
	load_data_high_score()
	if score > high_score:
		high_score = score
		save_high_score()
		$Label2.modulate = Color.GOLD
	$Label2.text = "%d" % high_score


func save_high_score():
	var file = FileAccess.open(save_path_high_score, FileAccess.WRITE)
	file.store_var(high_score)

func load_data_high_score():
	if FileAccess.file_exists(save_path_high_score):
		var file = FileAccess.open(save_path_high_score, FileAccess.READ)
		high_score = file.get_var()


func load_data_score():
	if FileAccess.file_exists(save_path_score):
		var file = FileAccess.open(save_path_score, FileAccess.READ)
		score = file.get_var()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_Stuff/Scenes/main_menu.tscn")
