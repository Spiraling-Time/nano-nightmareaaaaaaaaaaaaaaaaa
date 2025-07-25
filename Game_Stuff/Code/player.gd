extends RigidBody2D

var speed = 1000
var gravity = 0
var fake_scale = 1

var jump_height = 1000

var flight_power = 20

var max_turn_power = 1
var turn_power = max_turn_power

var left_pressed: bool = false
var right_pressed: bool = false

var spin_left : bool = false
var spin_right : bool = false


func _ready() -> void:

	$AnimationPlayer.play("Idle")

func _physics_process(delta: float) -> void:
	if global_position.x > $"../human_body".global_position.x: $Sprite2D.flip_h = true
	else: $Sprite2D.flip_h = false
	if $AnimationPlayer.current_animation == "Fly":
		if $Area2D.get_overlapping_bodies().size() > 0:
			for bodies in $Area2D.get_overlapping_bodies():
				if bodies != self and bodies.has_method("delete_self"):
					bodies.get_parent().number_of_bots -= 1
					bodies.delete_self()



func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	#if Input.get_action_strength("spin") >= .1:
		#turn_power = max_turn_power * 20
	#else: turn_power = max_turn_power
	

	if Input.get_action_strength("up") >= .1:
		apply_central_impulse(Vector2.UP.rotated(rotation) * flight_power)
		$AnimationPlayer.play("Fly")
	else:
		$AnimationPlayer.play("Idle")

	if Input.get_action_strength("left") >= .1:
		if spin_left:
			left_pressed = true
			angular_velocity = -20*turn_power
		else:
			left_pressed = true
			angular_velocity = -1*turn_power
	
	elif Input.get_action_strength("right") >= .1:
		if spin_right:
			right_pressed = true
			angular_velocity = 20*turn_power
		else:
			right_pressed = true
			angular_velocity = turn_power
	
	if Input.get_action_strength("left") <= 0:
		if left_pressed:
			left_pressed = false
			spin_left = false
			$left_timer.start()

	if Input.get_action_strength("right") <= 0:
		if right_pressed:
			right_pressed = false
			spin_right = false
			$right_timer.start()


func _on_left_timer_timeout() -> void:
	if left_pressed: spin_left = true

func _on_right_timer_timeout() -> void:
	if right_pressed: spin_right = true
