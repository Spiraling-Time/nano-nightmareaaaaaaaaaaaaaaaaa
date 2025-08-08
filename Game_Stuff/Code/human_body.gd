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
@onready var turn_around_timer = $turnaroundtimer

@onready var player = $"../player"

@onready var mood_timer = $"mood timer"

@onready var spawn_timer = $"respawn nanobots"

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

func _ready() -> void:
	reset_basic_position()
	reset_basic_rotation()
	turn_around_timer.start()
	turn_around_timer.timeout
	mood_timer.start()
	spawn_timer.start()
	mood_timer.timeout
	max_speed = 10

func _physics_process(delta: float) -> void:

			
	#print("nano: ", global_position.x, " player: ", $"../player".global_position.x)
	if leg_mode == "WALK":
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
			
			
			
			
	if !standing1.is_colliding() and !standing2.is_colliding():
		position.y += fall_speed * delta *60
		if !standing1.is_colliding() and !standing2.is_colliding():
			fall_speed = fall_speed*1.1
		else:
			position.y -= fall_speed
			fall_speed = 1
	if position.y >= 936.0: position.y = 936.0

func reset_basic_position():
	basic_positions(true, true, true, true, true, true, true, true, true, true)

func basic_positions(a: bool, b: bool, c: bool, d: bool, e: bool, f: bool, g: bool, h: bool, i: bool, j: bool):
	if a: torso.position = Vector2(25.0, 232.0)
	if b: head.position = Vector2(-1.0, -297.0)
	if c: upper_arm1.position = Vector2(-101.0, -148.0)
	if d: lower_arm1.position = Vector2(-200.0, 26.0)
	if e: upper_arm2.position = Vector2(101.0, -148.0)
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


func _on_turnaroundtimer_timeout() -> void:
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
	#print(facing)

func _on_temporary_mood_timer_timeout() -> void:
	if abs(global_position.x-player.global_position.x) <= 350:
		leg_mode = "IDLE"
		reset_basic_position()
		basic_rotation(false, false, false, false, false, false, true, false, true, false)
	elif abs(global_position.x-player.global_position.x) <= 650:
		max_speed = 5
		leg_mode = "WALK"
	else:
		max_speed = 10
		leg_mode = "WALK"
	
	if arm_mode == "IDLE":
		arm_mode = "ATTACK1"
	elif arm_mode == "ATTACK1":
		if randi_range(0, 1) == 0: upper_arm1.rotation_dir_thing = upper_arm1.rotation_dir_thing * -1
		if randi_range(0, 1) == 0: upper_arm2.rotation_dir_thing = upper_arm2.rotation_dir_thing * -1
		
		
	print("leg_mode: ", leg_mode, " leg_speed: ", max_speed)
	print("arm_mode: ", arm_mode)
	print(abs(global_position.x-player.global_position.x))
