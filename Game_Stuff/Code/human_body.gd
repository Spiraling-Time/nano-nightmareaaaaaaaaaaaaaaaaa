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

var max_speed = 10
var speed = max_speed

var debugging: bool = false

var mode = "WALK"

var fall_speed = 1


var walk_type:bool = false


var distribution: Array = []

var facing = "left"

func _ready() -> void:
	basic_position()
	basic_rotation()

func _physics_process(delta: float) -> void:
	if $"../player".global_position.distance_to(global_position) >= 300:
		if global_position.x > $"../player".global_position.x:
			facing = "left"
			speed = max_speed*-1
		else:
			facing = "right"
			speed = max_speed
			
	#print("nano: ", global_position.x, " player: ", $"../player".global_position.x)
	if mode == "WALK":
		if $Animation_Timer.is_stopped():
			walk_type = !walk_type
			$Animation_Timer.start()
		if speed > 0:
			if !near_wall1.is_colliding():
				position.x += speed
		elif !near_wall2.is_colliding():
			position.x += speed
	
	if !standing1.is_colliding() and !standing2.is_colliding():
		position.y += fall_speed
		if !standing1.is_colliding() and !standing2.is_colliding():
			fall_speed = fall_speed*1.1
		else:
			position.y -= fall_speed
			fall_speed = 1
	if position.y >= -446.363: position.y = -446.363
	
func basic_position():
	#position.y = -446.363
	if facing == "left":
		torso.position = Vector2(25.0, 232.0)
		head.position = Vector2(-1.0, -297.0)
		upper_arm1.position = Vector2(-189.0, -148.0)
		lower_arm1.position = Vector2(-200.0, 26.0)
		upper_arm2.position = Vector2(139.0, -148.0)
		lower_arm2.position = Vector2(200.0, 26.0)
		upper_leg1.position = Vector2(-109.0, 260.0)
		lower_leg1.position = Vector2(-94.0, 168.0)
		upper_leg2.position = Vector2(139.0, 260.0)
		lower_leg2.position = Vector2(-32.00, 174.0)
	else:
		torso.position = Vector2(-25.0, 232.0)
		head.position = Vector2(1.0, -297.0)
		upper_arm1.position = Vector2(189.0, -148.0)
		lower_arm1.position = Vector2(200.0, 26.0)
		upper_arm2.position = Vector2(-139.0, -148.0)
		lower_arm2.position = Vector2(-200.0, 26.0)
		upper_leg1.position = Vector2(109.0, 260.0)
		lower_leg1.position = Vector2(94.0, 168.0)
		upper_leg2.position = Vector2(-139.0, 260.0)
		lower_leg2.position = Vector2(32.00, 174.0)	

func basic_rotation():
	upper_leg1.rotation = 0.0
	upper_leg2.rotation = 0.0

func walk_position1():
	basic_position()
	if facing == "left":
		upper_leg1.rotation = 100
		upper_leg2.rotation = -100
		#upper_leg1.position = Vector2(-189.0, 160.0)
		#lower_leg1.position = Vector2(-94.0, 168.0)
		#upper_leg2.position = Vector2(195.0, 208.0)
		#lower_leg2.position = Vector2(-32.00, 174.0)
		
	else:
		upper_leg1.rotation = -100
		upper_leg2.rotation = 100
		#upper_leg1.position = Vector2(189.0, 160.0)
		#lower_leg1.position = Vector2(94.0, 168.0)
		#upper_leg2.position = Vector2(-195.0, 208.0)
		#lower_leg2.position = Vector2(32.00, 174.0)

func walk_position2():
	upper_leg1.rotation = 0
	upper_leg2.rotation = 0



func _on_animation_timer_timeout() -> void:
	if !walk_type: walk_position1()
	else: walk_position2()
