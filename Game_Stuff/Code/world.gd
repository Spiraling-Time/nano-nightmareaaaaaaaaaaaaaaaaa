extends Node2D

var save_path_score = "user://variable.score"
var score = 0

var world_type = "BOSS"

var total_nanobots = 0

@onready var timer = $"Time left"
@onready var labeltimeleft = $"player/CanvasLayer/Time Left"

@onready var mainmuse = $"main music"

func _ready() -> void:
	randomize()
	timer.start()
	mainmuse.play()

func end_game():
	if get_tree():
		score = 600-timer.time_left
		save_score()
		get_tree().change_scene_to_file("res://Game_Stuff/Scenes/lose.tscn")

func _physics_process(delta: float) -> void:
	labeltimeleft.text = "%d" % timer.time_left
	if total_nanobots >= 1600: end_game()



func _on_time_left_timeout() -> void:
	get_tree().change_scene_to_file("res://Game_Stuff/Scenes/win.tscn")


func save_score():
	var file = FileAccess.open(save_path_score, FileAccess.WRITE)
	file.store_var(score)


func _on_main_music_finished() -> void:
	mainmuse.play()
