extends RigidBody2D

var speed = 1000
var gravity = 0
var fake_scale = 1

var jump_height = 1000

var flight_power = 20

var max_turn_power = 1
var turn_power = max_turn_power


var prev_pos = Vector2.ZERO


var next_ammo = 0
var ammo = 0

var shooting:bool = false




@onready var world = $".."
@onready var fire = $fire
@onready var ani = $AnimationPlayer
@onready var damager = $Area2D
@onready var fast_turn = $Area2D2
@onready var leftimer = $left_timer
@onready var rightimer = $right_timer
@onready var nanoboss = $"../human_body"
@onready var bodysprite = $body
@onready var turnaroundtimer = $turn_around_timer
@onready var uithing = $"Ammo and stuff"
@onready var ammo_ui = $"Ammo and stuff/Sprite2D"
@onready var labeltotalnano = $"Ammo and stuff/TotalNANOS"
@onready var sprite_close_laser = $close_laser
@onready var area_close_laser = $Area2D3




func _physics_process(delta: float) -> void:
	labeltotalnano.text = "%d" % world.total_nanobots
	if world.total_nanobots >= 1400:
		labeltotalnano.modulate = Color.RED
	else: labeltotalnano.modulate = Color.WHITE
	
	if shooting:
		for bodies in area_close_laser.get_overlapping_bodies():
			if bodies != self and bodies.has_method("delete_self"):
				bodies.get_parent().number_of_bots -= 1
				bodies.delete_self()



func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	ammo_ui.frame = ammo
	if world.world_type == "BOSS":
		if position.y >= 1752.0 or position.y <= -1752.0 or position.x <= -4888.0 or position.x >= 4888.0:
			world.end_game()
	
	prev_pos = global_position
	
	if ani.current_animation == "Fly":
		if damager.get_overlapping_bodies().size() > 0:
			for bodies in damager.get_overlapping_bodies():
				if bodies != self and bodies.has_method("delete_self"):
					bodies.get_parent().number_of_bots -= 1
					bodies.delete_self()
					if next_ammo < 10:
						next_ammo += 1
					if next_ammo >= randi_range(5,10):
						next_ammo = 0
						if ammo < 9: ammo += 1
						if ammo > 9: ammo = 9



	

	if Input.is_action_pressed("up"):
		#up_pressed = true
		fire.visible = true
		apply_central_impulse(Vector2.UP.rotated(rotation) * flight_power)
		ani.play("Fly")
	else:
		fire.visible = false
	
	if fast_turn.get_overlapping_bodies().size() >= 1:
		if Input.is_action_pressed("left"): angular_velocity = -10*turn_power
		elif Input.is_action_pressed("right"): angular_velocity = 10*turn_power
	else:
		if Input.is_action_pressed("left"): angular_velocity = -1*turn_power
		elif Input.is_action_pressed("right"): angular_velocity = turn_power

	if Input.is_action_just_pressed("shoot"):
		if ammo > 0:
			shooting = true
			sprite_close_laser.visible = true
			ammo -= 1
			for i in 5: if get_tree(): await get_tree().process_frame
			sprite_close_laser.visible = false
			shooting = false
		

func damage(damage):
	pass


func _on_turn_around_timer_timeout() -> void:
	if world.world_type == "BOSS":
		if abs(global_position.x-nanoboss.global_position.x) >= 300:
			if global_position.x > nanoboss.global_position.x:
				bodysprite.flip_h = true
				sprite_close_laser.flip_h = true

			else:
				bodysprite.flip_h = false
				sprite_close_laser.flip_h = false
