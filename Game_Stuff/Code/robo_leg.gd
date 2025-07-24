extends RigidBody2D

@onready var ani = $AnimationPlayer

var power = 20 #5000 #20 #500
var max_flight_power = 500

var leg_flight_power = 0

var leg_number = 0

var pin



func _ready() -> void:
	ani.play("Idle")
	if leg_number == 1: pin = $"../PinJoint2D1"
	elif leg_number == 2: pin = $"../PinJoint2D2"



func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#if Input.get_action_strength("stop") >=1:
		##power = 40
		#leg_flight_power = 0
	##else: power = 20
	
	
	if leg_number == 1:
		if Input.get_action_strength("front_left") >=1:
			angular_velocity = -1*power
			#apply_torque_impulse(power*-1)
			#apply_torque(-1*power)
		elif Input.get_action_strength("front_right") >=1:
			angular_velocity = power
			#apply_torque_impulse(power)
			#apply_torque(power)
		
		#if Input.get_action_strength("front_up") >=1:
			#leg_flight_power = leg_flight_power*1.1 + .001
			#if leg_flight_power > max_flight_power: leg_flight_power = max_flight_power
			#ani.play("Fly")
			#if leg_flight_power > 1: linear_velocity = Vector2.UP.rotated(rotation) * leg_flight_power
			##apply_central_force(Vector2.UP.rotated(rotation)*flight_power)
		#else:
			##$"../PinJoint2D1".angular_limit_enabled = false
			#leg_flight_power = 0
			#ani.play("Idle")
		
	elif leg_number == 2:
		if Input.get_action_strength("back_left") >=1:
			angular_velocity =-1* power
			#apply_torque_impulse(power*-1)
			#apply_torque(-1*power)
		elif Input.get_action_strength("back_right") >=1:
			angular_velocity = power
			#apply_torque_impulse(power)
			#apply_torque(power)
		
		#if Input.get_action_strength("back_up") >=1:
			#leg_flight_power = leg_flight_power*1.1 + .001
			#if leg_flight_power > max_flight_power: leg_flight_power = max_flight_power
			#ani.play("Fly")
			#if leg_flight_power > 1: linear_velocity = Vector2.UP.rotated(rotation) * leg_flight_power
			##apply_central_force(Vector2.UP.rotated(rotation)*flight_power)
		#else:
			#leg_flight_power = 0
			#ani.play("Idle")
	

	
	#if ani.current_animation == "Fly":
		#if $Area2D.get_overlapping_bodies().size() > 0:
			#for bodies in $Area2D.get_overlapping_bodies():
				#if bodies != self and bodies.has_method("delete_self"):
					##$"..".max_number_of_bots -= 1
					#bodies.get_parent().number_of_bots -= 1
					## FIX THIS $"..".number_of_bots -= 1
					#bodies.delete_self()
	
	
func burn_active():
	$Area2D/CollisionShape2D.disabled = false
	
	
func burn_deactivated():
	$Area2D/CollisionShape2D.disabled = true
