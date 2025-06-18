extends Node2D

@export var bot = preload("res://Game_Stuff/Scenes/nanobot.tscn")

var number_of_bots = 0

func _ready() -> void:
	randomize()
	spawn_bots(145)

func _physics_process(delta: float) -> void:
	pass
	
	
func spawn_bots(count: int):
	for i in count:
		if number_of_bots < 146:
			number_of_bots += 1
			var new_bot = bot.instantiate()
			if number_of_bots <= 145:
				new_bot.nano_type = "TORSO"
				new_bot.nano_home = $human_body/body/torso.global_position
				new_bot.nano_size_x = 75
				new_bot.nano_size_y = 200
				new_bot.position = $human_body/body/torso.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			
			
			
			add_child(new_bot)
