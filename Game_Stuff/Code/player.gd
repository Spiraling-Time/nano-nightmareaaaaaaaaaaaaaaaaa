extends RigidBody2D

var speed = 1000
var gravity = 0
var fake_scale = 1

var jump_height = 1000

var flight_power = 20

var max_turn_power = 1
var turn_power = max_turn_power


var prev_pos = Vector2.ZERO

@onready var world = $".."
@onready var fire = $fire
@onready var ani = $AnimationPlayer
@onready var damager = $Area2D
@onready var fast_turn = $Area2D2
@onready var leftimer = $left_timer
@onready var rightimer = $right_timer
@onready var nanoboss = $"../human_body"
@onready var bodysprite = $body




func _physics_process(delta: float) -> void:
	if global_position.x > nanoboss.global_position.x: bodysprite.flip_h = true
	else: bodysprite.flip_h = false


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if position.y >= 248.0 or position.y <=-2808.0 or position.x <= -4352.0 or position.x >= 4488.0: #global_position.distance_to(prev_pos) >= 2000: #or position.y >= 248.0 or position.x <= -4352.0 or position.x >= 4488.0:
		world.end_game()
	
	prev_pos = global_position
	
	if ani.current_animation == "Fly":
		if damager.get_overlapping_bodies().size() > 0:
			for bodies in damager.get_overlapping_bodies():
				if bodies != self and bodies.has_method("delete_self"):
					bodies.get_parent().number_of_bots -= 1
					bodies.delete_self()

	

	if Input.is_action_pressed("up"):
		#up_pressed = true
		fire.visible = true
		apply_central_impulse(Vector2.UP.rotated(rotation) * flight_power)
		ani.play("Fly")
	else:
		fire.visible = false
	
	if fast_turn.get_overlapping_bodies().size() >= 2:
		if Input.is_action_pressed("left"): angular_velocity = -10*turn_power
		elif Input.is_action_pressed("right"): angular_velocity = 10*turn_power
	else:
		if Input.is_action_pressed("left"): angular_velocity = -1*turn_power
		elif Input.is_action_pressed("right"): angular_velocity = turn_power



func damage(damage):
	pass
