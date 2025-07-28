extends Node2D

@export var bot = preload("res://Game_Stuff/Scenes/nanobot.tscn")


var type_of_part# = null
var number_of_bots = 0
var max_number_of_bots# = null #800
var parts_able_to_hurt: bool = false


func _physics_process(delta: float) -> void:
	if max_number_of_bots - number_of_bots >= 1:
		spawn_bots(1)
	#wprint(max_number_of_bots - number_of_bots)
	#pass#Check spawn so dont;' soawn in player
	
func spawn_bots(count: int):
	for i in count:
		if number_of_bots < max_number_of_bots:
			number_of_bots += 1
			var new_bot = bot.instantiate() #ADD WORLD. maybe not world.
			if type_of_part == "torso": #number_of_bots <= 150:
				#new_bot.nano_type = "TORSO"
				new_bot.nano_size_x = 120
				new_bot.nano_size_y = 200
				#new_bot.position = $human_body/body/torso.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))

			elif type_of_part == "head": #number_of_bots <= 400:
				#new_bot.nano_type = "HEAD"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 100
				#new_bot.position = $human_body/body/head.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))

			elif type_of_part == "upper_arm1": #number_of_bots <= 450:
				#new_bot.nano_type = "UPPER_ARM1"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/upper_arm1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			elif type_of_part == "lower_arm1":# number_of_bots <= 500:
				#new_bot.nano_type = "LOWER_ARM1"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_arm1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			elif type_of_part == "upper_arm2": #number_of_bots <= 550:
				#new_bot.nano_type = "UPPER_ARM2"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/upper_arm2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			elif type_of_part == "lower_arm2":# number_of_bots <= 600:
				#new_bot.nano_type = "LOWER_ARM2"
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_arm2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			elif type_of_part == "upper_leg1": #number_of_bots <= 650:
				#new_bot.nano_type = "UPPER_LEG1"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 200
				#new_bot.position = $human_body/body/upper_leg1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			elif type_of_part == "lower_leg1": #number_of_bots <= 700:
				#new_bot.nano_type = "LOWER_LEG1"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_leg1.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			elif type_of_part == "upper_leg2": #number_of_bots <= 750:
				#new_bot.nano_type = "UPPER_LEG2"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 200
				#new_bot.position = $human_body/body/upper_leg2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			elif type_of_part == "lower_leg2": #number_of_bots <= 800:
				#new_bot.nano_type = "LOWER_LEG2"
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 40
				#new_bot.position = $human_body/body/lower_leg2.global_position + Vector2(randi_range(-10,10),randi_range(-10,10))
			new_bot.position += Vector2(randi_range(-100,100),randi_range(-100,100))

			add_child(new_bot)
			get_owner().get_node("Area2D").global_position = new_bot.global_position
			#print(get_owner().get_node("Area2D").global_position)
			for bodies in get_owner().get_node("Area2D").get_overlapping_bodies():
				if bodies.has_method("damage"):
					number_of_bots -= 1
					new_bot.queue_free()
			if new_bot: new_bot.start()
