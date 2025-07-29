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

var max_speed = 10
var speed = max_speed

var debugging: bool = false

var overall_mode = "IDLE"
var arm_mode = "ATTACK1"#"IDLE"
var leg_mode = "WALK"#"IDLE"

var fall_speed = 1


var leg1_movement = "Forward"
var leg2_movement = "Backward"


var distribution: Array = []

var facing = "left"

func _ready() -> void:
	reset_basic_position()
	basic_rotation()

func _physics_process(delta: float) -> void:

			
	#print("nano: ", global_position.x, " player: ", $"../player".global_position.x)
	if leg_mode == "WALK":
		if leg_height_resetter.is_stopped():
			reset_basic_position()
			leg_height_resetter.start()
			#print("restarting")
		if speed > 0:
			if !near_wall1.is_colliding():
				position.x += speed
		elif !near_wall2.is_colliding():
			position.x += speed
		if speed < 50 and speed > -50: speed = speed*1.01
		if speed > 50: speed = 50
		elif speed < -50: speed = -50
		basic_positions(false, false, false, false, false, false, false, true, false, true)
		if leg1_movement == "Forward":
			if facing == "left":
				upper_leg1.position.y += 1
				upper_leg1.rotation += 0.2
				#upper_leg2.rotation += -0.1
				#print(upper_leg1.rotation)
				if upper_leg1.rotation >= 2:
					leg1_movement = "Backward"
					
			else:
				upper_leg1.position.y -= 2
				upper_leg1.rotation += -0.2
				#upper_leg2.rotation += 0.1
				if upper_leg1.rotation <= -0.6:
					leg1_movement = "Backward"
					

		elif leg1_movement == "Backward":
			if facing == "left":
				upper_leg1.position.y -= 2
				upper_leg1.rotation += -0.2
				#upper_leg2.rotation += 0.1
				if upper_leg1.rotation <= -0.6:
					leg1_movement = "Forward"
				
			else:
				upper_leg1.position.y += 1
				upper_leg1.rotation += 0.2
				#upper_leg2.rotation += -0.1
				if upper_leg1.rotation >= 2:
					leg1_movement = "Forward"
					
		if leg2_movement == "Forward":
			if facing == "left":
				upper_leg2.position.y -= 2
				upper_leg2.rotation += 0.2
				#upper_leg2.rotation += -0.1
				#print(upper_leg1.rotation)
				if upper_leg2.rotation >= 0.6:
					leg2_movement = "Backward"
			else:
				upper_leg2.position.y += 1
				upper_leg2.rotation += -0.2
				#upper_leg2.rotation += 0.1
				if upper_leg2.rotation <= -2:
					leg2_movement = "Backward"
					
		elif leg2_movement == "Backward":
			if facing == "left":
				upper_leg2.position.y += 1
				upper_leg2.rotation += -0.2
				#upper_leg2.rotation += 0.1
				if upper_leg2.rotation <= -2:
					leg2_movement = "Forward"
					
			else:
				upper_leg2.position.y -= 2
				upper_leg2.rotation += 0.2
				#upper_leg2.rotation += -0.1
				if upper_leg2.rotation >= 0.6:
					leg2_movement = "Forward"
					
					
		#print("leg1_movement: ", leg1_movement, " leg2_movement: ", leg2_movement)
		#print("leg1_rotation: ", upper_leg1.rotation, " leg2_rotation: ", upper_leg2.rotation)
			
			
			
			
	if !standing1.is_colliding() and !standing2.is_colliding():
		position.y += fall_speed
		if !standing1.is_colliding() and !standing2.is_colliding():
			fall_speed = fall_speed*1.1
		else:
			position.y -= fall_speed
			fall_speed = 1
	if position.y >= -446.363: position.y = -446.363

func reset_basic_position():
	basic_positions(true, true, true, true, true, true, true, true, true, true)

func basic_positions(a: bool, b: bool, c: bool, d: bool, e: bool, f: bool, g: bool, h: bool, i: bool, j: bool):
	#position.y = -446.363
	if facing == "left":
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
	else:
		if a: torso.position = Vector2(-25.0, 232.0)
		if b: head.position = Vector2(1.0, -297.0)
		if c: upper_arm1.position = Vector2(101.0, -148.0)
		if d: lower_arm1.position = Vector2(200.0, 26.0)
		if e: upper_arm2.position = Vector2(-101.0, -148.0)
		if f: lower_arm2.position = Vector2(-200.0, 26.0)
		if g: upper_leg1.position = Vector2(109.0, 260.0)
		if h: lower_leg1.position = Vector2(94.0, 168.0)
		if i: upper_leg2.position = Vector2(-139.0, 260.0)
		if j: lower_leg2.position = Vector2(32.00, 174.0)	

func basic_rotation():
	upper_leg1.rotation = 0.0
	upper_leg2.rotation = 0.0

#func walk_position1():
	#basic_position()
	#if facing == "left":
		#upper_leg1.rotation = 100
		#upper_leg2.rotation = -100
		##upper_leg1.position = Vector2(-189.0, 160.0)
		##lower_leg1.position = Vector2(-94.0, 168.0)
		##upper_leg2.position = Vector2(195.0, 208.0)
		##lower_leg2.position = Vector2(-32.00, 174.0)
		#
	#else:
		#upper_leg1.rotation = -100
		#upper_leg2.rotation = 100
		##upper_leg1.position = Vector2(189.0, 160.0)
		##lower_leg1.position = Vector2(94.0, 168.0)
		##upper_leg2.position = Vector2(-195.0, 208.0)
		##lower_leg2.position = Vector2(32.00, 174.0)

#func walk_position2():
	#basic_position()
	#upper_leg1.rotation = 0
	#upper_leg2.rotation = 0


func _on_turnaroundtimer_timeout() -> void:
	if global_position.x > $"../player".global_position.x:
		if speed >0:
			facing = "left"
			speed = max_speed*-1
			basic_rotation()
	elif speed <0:
		facing = "right"
		speed = max_speed
		basic_rotation()


func _on_temporary_mood_timer_timeout() -> void:
	#if leg_mode == "IDLE": leg_mode = "WALK"
	#elif leg_mode == "WALK": leg_mode = "IDLE"
	
	#if arm_mode == "IDLE": arm_mode = "ATTACK1"
	#elif arm_mode == "ATTACK1": arm_mode = "IDLE"
	pass
