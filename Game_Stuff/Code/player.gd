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

var up_pressed:bool = false

var spin_left : bool = false
var spin_right : bool = false

var spin_up : bool = false




func _physics_process(delta: float) -> void:
	#if global_position.x > $"../human_body".global_position.x: $body.flip_h = true
	#else: $body.flip_h = false
	#if $AnimationPlayer.current_animation == "Fly":
		#if $Area2D.get_overlapping_bodies().size() > 0:
			#for bodies in $Area2D.get_overlapping_bodies():
				#if bodies != self and bodies.has_method("delete_self"):
					#bodies.get_parent().number_of_bots -= 1
					#bodies.delete_self()
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if global_position.x > $"../human_body".global_position.x: $body.flip_h = true
	else: $body.flip_h = false
	if $AnimationPlayer.current_animation == "Fly":
		if $Area2D.get_overlapping_bodies().size() > 0:
			for bodies in $Area2D.get_overlapping_bodies():
				if bodies != self and bodies.has_method("delete_self"):
					bodies.get_parent().number_of_bots -= 1
					bodies.delete_self()

	

	if Input.get_action_strength("up") >= .1:
		#up_pressed = true
		$fire.visible = true
		apply_central_impulse(Vector2.UP.rotated(rotation) * flight_power)
		$AnimationPlayer.play("Fly")
	else:
		$fire.visible = false
		
	if Input.get_action_strength("left") >= .1:
		left_pressed = true
		if spin_left:
			angular_velocity = -20*turn_power

		else:
			angular_velocity = -1*turn_power

			
			
			
	elif Input.get_action_strength("right") >= .1:
		right_pressed = true
		if spin_right:
			angular_velocity = 20*turn_power
		else:
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

	#if Input.get_action_strength("up") <= 0:
		#if up_pressed:
			#up_pressed = false
			#spin_up = false
			#$up_timer.start()


func _on_left_timer_timeout() -> void:
	if left_pressed: spin_left = true

func _on_right_timer_timeout() -> void:
	if right_pressed: spin_right = true


#func _on_up_timer_timeout() -> void:
	#if up_pressed: spin_up = true
