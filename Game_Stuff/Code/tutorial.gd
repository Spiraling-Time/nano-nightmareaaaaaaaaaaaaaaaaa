extends Node2D

var world_type = "TUTORIAL"

var total_nanobots = 0

var save_path_first_time = "user://variable.the_first_time"
var first_time: bool = true

@onready var muse = $audio

func _ready() -> void:
	save_first_time()
	load_data_first_time()
	if !first_time: get_tree().change_scene_to_file("res://Game_Stuff/Scenes/main_menu.tscn")
	else:
		muse.play()
	
func save_first_time():
	var file = FileAccess.open(save_path_first_time, FileAccess.WRITE)
	file.store_var(first_time)


func load_data_first_time():
	if FileAccess.file_exists(save_path_first_time):
		var file = FileAccess.open(save_path_first_time, FileAccess.READ)
		first_time = file.get_var()

func _physics_process(delta: float) -> void:
	if $player in $Area2D2.get_overlapping_bodies():
		first_time = false
		save_first_time()
		get_tree().change_scene_to_file("res://Game_Stuff/Scenes/main_menu.tscn")


func _on_audio_stream_player_2d_finished() -> void:
	muse.play()
