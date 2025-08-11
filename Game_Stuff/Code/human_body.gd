extends Node2D

@onready var torso = $body/torso
@onready var head = $body/torso/head
@onready var upper_arm1 = $body/torso/upper_arm1
@onready var lower_arm1 = $body/torso/upper_arm1/lower_arm1
@onready var upper_arm2 = $body/torso/upper_arm2
@onready var lower_arm2 = $body/torso/upper_arm2/lower_arm2
@onready var upper_leg1 = $body/torso/upper_leg1
@onready var lower_leg1 = $body/torso/upper_leg1/lower_leg1
@onready var upper_leg2 = $body/torso/upper_leg2
@onready var lower_leg2 = $body/torso/upper_leg2/lower_leg2

@onready var standing1 = $body/torso/upper_leg1/lower_leg1/standing
@onready var standing2 = $body/torso/upper_leg2/lower_leg2/standing

@onready var near_wall1 = $body/torso/near_wall1
@onready var near_wall2 = $body/torso/near_wall2

@onready var leg_height_resetter = $Reset_height

@onready var player = $"../player"

@onready var mood_timer = $"mood timer"

@onready var spawn_timer = $"respawn nanobots"

var lowest = 1000.0

var max_speed = 0
var speed = max_speed

var debugging: bool = false

var overall_mode = "IDLE"
var arm_mode = "IDLE"
var leg_mode = "IDLE"

var fall_speed = 1


var leg1_movement = "Forward"
var leg2_movement = "Backward"


var distribution: Array = []

var facing# = "left"

var spin_enough = 0

var attack_enough = -5


@export var custom = preload("res://Game_Stuff/Scenes/custom_nano.tscn")


func _ready() -> void:
	reset_basic_position()
	reset_basic_rotation()
	mood_timer.start()
	spawn_timer.start()
	mood_timer.timeout
	max_speed = 10

func _physics_process(delta: float) -> void:

	#print(speed)
	#print(rotation_degrees)
	if overall_mode == "IDLE":
		if abs(global_position.x-player.global_position.x) >= 400:
			if global_position.x > player.global_position.x:
				if !facing == "left":
					facing = "left"
					scale.x = 1
					speed = max_speed*-1
					basic_rotation(false, false, false, false, false, false, true, false, true, false)
			elif !facing == "right":
				facing = "right"
				scale.x = -1
				speed = max_speed
				basic_rotation(false, false, false, false, false, false, true, false, true, false)

		#print("nano: ", global_position.x, " player: ", $"../player".global_position.x)
		if leg_mode == "WALK":
			if speed == 0:
				if facing == "left": speed = max_speed*-1
				elif facing == "right": speed = max_speed
			if leg_height_resetter.is_stopped():
				reset_basic_position()
				leg_height_resetter.start()
				#print("restarting")
			if !near_wall2.is_colliding():
				if upper_leg1.number_of_bots >= 1 and upper_leg2.number_of_bots >= 1: position.x += delta*60*speed*(upper_leg1.max_number_of_bots / upper_leg1.number_of_bots)*(upper_leg2.max_number_of_bots / upper_leg2.number_of_bots)
				else: position.x += speed * delta * 60
			if speed < 50 and speed > -50: speed = speed*1.01
			if speed > 50: speed = 50
			elif speed < -50: speed = -50
			basic_positions(false, false, false, false, false, false, false, true, false, true)
			if leg1_movement == "Forward":
				upper_leg1.position.y += 1
				upper_leg1.rotation += 0.2
				#upper_leg2.rotation += -0.1
				#print(upper_leg1.rotation)
				if upper_leg1.rotation >= 2:
					leg1_movement = "Backward"

			elif leg1_movement == "Backward":
				upper_leg1.position.y -= 2
				upper_leg1.rotation += -0.2
				#upper_leg2.rotation += 0.1
				if upper_leg1.rotation <= -0.6:
					leg1_movement = "Forward"

						
			if leg2_movement == "Forward":
				upper_leg2.position.y -= 2
				upper_leg2.rotation += 0.2
				#upper_leg2.rotation += -0.1
				#print(upper_leg1.rotation)
				if upper_leg2.rotation >= 0.6:
					leg2_movement = "Backward"

						
			elif leg2_movement == "Backward":
				upper_leg2.position.y += 1
				upper_leg2.rotation += -0.2
				#upper_leg2.rotation += 0.1
				if upper_leg2.rotation <= -2:
					leg2_movement = "Forward"

						
						
			#print("leg1_movement: ", leg1_movement, " leg2_movement: ", leg2_movement)
			#print("leg1_rotation: ", upper_leg1.rotation, " leg2_rotation: ", upper_leg2.rotation)

		standing1.force_raycast_update()
		standing2.force_raycast_update()
		if !standing1.is_colliding() and !standing2.is_colliding():
			position.y += fall_speed * delta *60
			fall_speed = fall_speed*1.1			
		else:
			fall_speed = 1
		if position.y >= lowest: position.y = lowest
	





func reset_basic_position():
	basic_positions(true, true, true, true, true, true, true, true, true, true)

func basic_positions(a: bool, b: bool, c: bool, d: bool, e: bool, f: bool, g: bool, h: bool, i: bool, j: bool):
	if a: torso.position = Vector2(25.0, 232.0)
	if b: head.position = Vector2(-1.0, -297.0)
	if c: upper_arm1.position = Vector2(-90.0, -128.0)
	if d: lower_arm1.position = Vector2(-200.0, 26.0)
	if e: upper_arm2.position = Vector2(90.0, -128.0)
	if f: lower_arm2.position = Vector2(200.0, 26.0)
	if g: upper_leg1.position = Vector2(-109.0, 260.0)
	if h: lower_leg1.position = Vector2(-94.0, 168.0)
	if i: upper_leg2.position = Vector2(139.0, 260.0)
	if j: lower_leg2.position = Vector2(-32.00, 174.0)


func reset_basic_rotation():
	basic_positions(true, true, true, true, true, true, true, true, true, true)

func basic_rotation(a: bool, b: bool, c: bool, d: bool, e: bool, f: bool, g: bool, h: bool, i: bool, j: bool):
	if a: torso.rotation = 0.0
	if b: head.rotation = 0.0
	if c: upper_arm1.rotation = 0.0
	if d: lower_arm1.rotation = 0.0
	if e: upper_arm2.rotation = 0.0
	if f: lower_arm2.rotation = 0.0
	if g: upper_leg1.rotation = 0.0
	if h: lower_leg1.rotation = 0.0
	if i: upper_leg2.rotation = 0.0
	if j: lower_leg2.rotation = 0.0



	
func _on_temporary_mood_timer_timeout() -> void:
	if custom:
		attack_enough += 1
		if player.position.y <= 480.0 or player.position.y >= 1456.0 or player.position.x <= -4544.0 or player.position.x >= 4544.0 or abs(global_position.x-player.global_position.x) <= 150: attack_enough = attack_enough * 2
		if attack_enough >= randi_range(10,30):
			if torso.number_of_bots >= randi_range(70, 150) or (player.position.y <= 480.0 and torso.number_of_bots >= 50):
				var count = 0
				for i in torso.get_children():
					if i is Nanobot:
						torso.number_of_bots -= 1
						i.delete_self()
						count += 1
						#print(count)
						if count >= 50: break
				var new_custom = custom.instantiate()
				new_custom.type_of_movement = "Steady"
				new_custom.max_number_of_bots = 50


				new_custom.custom_offset = Vector2.ZERO

				new_custom.custom_speed = 50
				var true_dir_thing
				if player.position.y <= 480.0 or player.position.y >= 1456.0 or player.position.x <= -4544.0 or player.position.x >= 4544.0: true_dir_thing = Vector2(0, 1)
				else: true_dir_thing = Vector2(randi_range(1,-1), randi_range(1,-1))
				if player.position.y >= 1456.0: true_dir_thing.x = randi_range(1,-1)
				if true_dir_thing == Vector2(0,0): true_dir_thing = Vector2(0,1)
				new_custom.custom_dir = true_dir_thing
				new_custom.position = player.position + Vector2(true_dir_thing.x*200, true_dir_thing.y * -200)
				new_custom.custom_size_x = 100+abs(true_dir_thing.y)*100
				new_custom.custom_size_y = 100+abs(true_dir_thing.x)*100
				get_tree().current_scene.add_child(new_custom)
				attack_enough = 0
				
	if overall_mode == "IDLE":
		mood_timer.wait_time = 0.1
		if near_wall2.is_colliding():
			if max_speed > 0: max_speed = 0
			else:
				leg_mode = "IDLE"
				reset_basic_position()
				basic_rotation(false, false, false, false, false, false, true, false, true, false)
		elif abs(global_position.x-player.global_position.x) <= 650:
			max_speed = 5
			leg_mode = "WALK"
		else:
			max_speed = 8
			leg_mode = "WALK"

		if arm_mode == "IDLE":
			arm_mode = "ATTACK1"
			spin_enough = 0
		elif arm_mode == "ATTACK1":
			spin_enough += 1
			if spin_enough % 10 == 0:
				if randi_range(0, 1) == 0: upper_arm1.rotation_dir_thing = upper_arm1.rotation_dir_thing * -1
				if randi_range(0, 1) == 0: upper_arm2.rotation_dir_thing = upper_arm2.rotation_dir_thing * -1
			if spin_enough >= randi_range(400,500): arm_mode = "REST"
		elif arm_mode == "REST":
			spin_enough += 1
			if spin_enough >= 510: arm_mode = "IDLE"
		mood_timer.start()	

	
	#print("leg_mode: ", leg_mode, " leg_speed: ", max_speed)
	#print("arm_mode: ", arm_mode)
	#print(abs(global_position.x-player.global_position.x))
