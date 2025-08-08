extends Node2D

var world_type = "BOSS"

var total_nanobots = 0

func _ready() -> void:
	randomize()

func end_game():
	get_tree().paused = true
	#print("Is inside tree?", is_inside_tree())  # Should print true
	$Game_Ender.really_end_the_round()
