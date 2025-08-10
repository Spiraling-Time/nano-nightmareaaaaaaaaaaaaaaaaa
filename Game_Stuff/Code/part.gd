extends Node2D

@export var bot = preload("res://Game_Stuff/Scenes/nanobot.tscn")

@onready var world = get_tree().current_scene


var custom_size_x
var custom_size_y

var custom_offset

var custom_speed
var custom_dir

var the_parent



var type_of_part# = null
var number_of_bots = 0
var max_number_of_bots# = null #800
var parts_able_to_hurt: bool = false
var rotation_dir_thing = 6.0

var own_checker

#ARMS {
#var up_down_swing_attack = "Up"
#}

func _ready() -> void:
	await get_tree().process_frame
	spawn_bots(max_number_of_bots)
	
func _physics_process(delta: float) -> void:
	#if max_number_of_bots - number_of_bots >= 0:
		#spawn_bots(1)
	#wprint(max_number_of_bots - number_of_bots)
	if type_of_part == "upper_arm1" or type_of_part == "upper_arm2":
		if the_parent.arm_mode == "ATTACK1":
			rotation += rotation_dir_thing*delta

	
func spawn_bots(count: int):
	for i in count:
		if number_of_bots < max_number_of_bots:
			number_of_bots += 1
			var new_bot = bot.instantiate()
			if type_of_part == "torso":
				new_bot.nano_size_x = 120
				new_bot.nano_size_y = 200

			elif type_of_part == "head":
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 100

			elif type_of_part == "upper_arm1":
				new_bot.offset = Vector2(-150, -20)
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
			elif type_of_part == "lower_arm1":
				new_bot.offset = Vector2(-100, -20)
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
			elif type_of_part == "upper_arm2":
				new_bot.offset = Vector2(150, -20)
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
			elif type_of_part == "lower_arm2":
				new_bot.offset = Vector2(100, -20)
				new_bot.nano_size_x = 150
				new_bot.nano_size_y = 40
			elif type_of_part == "upper_leg1":
				#new_bot.offset = Vector2(0, -100)
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 200
			elif type_of_part == "lower_leg1":
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 40
			elif type_of_part == "upper_leg2":
				#new_bot.offset = Vector2(0, -100)
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 200
			elif type_of_part == "lower_leg2":
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 40

			elif type_of_part == "floor":
				new_bot.nano_size_x = 100
				new_bot.nano_size_y = 100

			elif type_of_part == "custom":
				new_bot.offset = custom_offset
				new_bot.nano_size_x = custom_size_x
				new_bot.nano_size_y = custom_size_y


			new_bot.position += Vector2(randi_range(randi_range(100,-100) + new_bot.offset.x + new_bot.nano_size_x/2, new_bot.offset.x - new_bot.nano_size_x/2), randi_range(randi_range(100,-100) + new_bot.offset.y + new_bot.nano_size_y/2, new_bot.offset.y - new_bot.nano_size_y/2)) #randi_range(-100,100),randi_range(-100,100)

			add_child(new_bot)
			if type_of_part == "custom": own_checker.global_position = new_bot.global_position
			else: get_owner().get_node("Area2D").global_position = new_bot.global_position
			#print(get_owner().get_node("Area2D").global_position)
			world.total_nanobots += 1
			for bodies in get_owner().get_node("Area2D").get_overlapping_bodies():
				if bodies.has_method("damage"):
					number_of_bots -= 1
					world.total_nanobots -= 1
					new_bot.queue_free()
			if new_bot: new_bot.start()
