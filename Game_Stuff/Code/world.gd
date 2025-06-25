extends Node2D

@export var bot = preload("res://Game_Stuff/Scenes/nanobot.tscn")

var number_of_bots = 0
var max_number_of_bots = 800


func _ready() -> void:
	randomize()
	await get_tree().process_frame
	spawn_bots(800)

func _physics_process(delta: float) -> void:
	#if max_number_of_bots - number_of_bots >= 10:
		#spawn_bots(randi_range(1,10))
	#print(max_number_of_bots - number_of_bots)
	pass
	
func spawn_bots(count: int):
	for i in count:
		if number_of_bots < max_number_of_bots:
			number_of_bots += 1
			var new_bot = bot.instantiate()
			if number_of_bots <= 150:
				#new_bot.nano_type = "TORSO"
				new_bot.nano_size_x = 120
				new_bot.nano_size_y = 200
				#new_bot.position = $human_body/body/torso.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso.add_child(new_bot)
			elif number_of_bots <= 400:
				#new_bot.nano_type = "HEAD"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 100
				#new_bot.position = $human_body/body/head.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/head.add_child(new_bot)

			elif number_of_bots <= 450:
				#new_bot.nano_type = "UPPER_ARM1"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/upper_arm1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_arm1.add_child(new_bot)
			elif number_of_bots <= 500:
				#new_bot.nano_type = "LOWER_ARM1"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_arm1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_arm1/lower_arm1.add_child(new_bot)
			elif number_of_bots <= 550:
				#new_bot.nano_type = "UPPER_ARM2"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/upper_arm2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_arm2.add_child(new_bot)
			elif number_of_bots <= 600:
				#new_bot.nano_type = "LOWER_ARM2"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_arm2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_arm2/lower_arm2.add_child(new_bot)
			elif number_of_bots <= 650:
				#new_bot.nano_type = "UPPER_LEG1"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 200
				#new_bot.position = $human_body/body/upper_leg1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_leg1.add_child(new_bot)
			elif number_of_bots <= 700:
				#new_bot.nano_type = "LOWER_LEG1"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_leg1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_leg1/lower_leg1.add_child(new_bot)
			elif number_of_bots <= 750:
				#new_bot.nano_type = "UPPER_LEG2"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 200
				#new_bot.position = $human_body/body/upper_leg2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_leg2.add_child(new_bot)
			elif number_of_bots <= 800:
				#new_bot.nano_type = "LOWER_LEG2"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_leg2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
				$human_body/body/torso/upper_leg2/lower_leg2.add_child(new_bot)
		
