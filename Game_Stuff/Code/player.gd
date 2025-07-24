extends RigidBody2D

var speed = 1000
var gravity = 0
var fake_scale = 1

var jump_height = 1000

func _ready() -> void:
	$Robo_leg1.leg_number = 1
	$Robo_leg2.leg_number = 2

func _physics_process(delta: float) -> void:
	if global_position.x > $"../human_body".global_position.x: $Sprite2D.flip_h = true
	else: $Sprite2D.flip_h = false
	#if Input.get_action_strength("gravity_shift") >= 1:
		#PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, (global_position.direction_to($"../human_body".global_position)).normalized())
	#if Input.get_action_strength("front_left") >= 1 or Input.get_action_strength("back_left") >= 1:
		#angular_velocity = -1
	#elif Input.get_action_strength("front_right") >= 1 or Input.get_action_strength("back_right") >= 1:
		#angular_velocity = 1
