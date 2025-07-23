extends RigidBody2D

@onready var ani = $AnimationPlayer

var power = 500

var leg_number = 0

var pin



func _ready() -> void:
	ani.play("Idle")
	if leg_number == 1: pin = $"../PinJoint2D1"
	elif leg_number == 2: pin = $"../PinJoint2D2"

func _physics_process(delta: float) -> void:
	
	if $"..".global_position.x > get_global_mouse_position().x: $"../Sprite2D".flip_h = true
	else: $"../Sprite2D".flip_h = false
	
	if leg_number == 1:
		if Input.get_action_strength("front_left") >=1:
			
			apply_torque_impulse(power*-1)
		elif Input.get_action_strength("front_right") >=1:
			apply_torque_impulse(power)
		
		if Input.get_action_strength("front_up") >=1:
			ani.play("Fly")
			linear_velocity = Vector2.UP.rotated(rotation) * power/2
		else:
			#$"../PinJoint2D1".angular_limit_enabled = false
			ani.play("Idle")
			
	elif leg_number == 2:
		if Input.get_action_strength("back_left") >=1:
			apply_torque_impulse(power*-1)
		elif Input.get_action_strength("back_right") >=1:
			apply_torque_impulse(power)
		
		if Input.get_action_strength("back_up") >=1:
			ani.play("Fly")
			linear_velocity = Vector2.UP.rotated(rotation) * power/2
		else:
			ani.play("Idle")
	
	
	if ani.current_animation == "Fly":
		if $Area2D.get_overlapping_bodies().size() > 0:
			for bodies in $Area2D.get_overlapping_bodies():
				if bodies != self and bodies.has_method("delete_self"):
					#$"..".max_number_of_bots -= 1
					bodies.get_parent().number_of_bots -= 1
					# FIX THIS $"..".number_of_bots -= 1
					bodies.delete_self()


func burn_active():
	$Area2D/CollisionShape2D.disabled = false
	
	
func burn_deactivated():
	$Area2D/CollisionShape2D.disabled = true
