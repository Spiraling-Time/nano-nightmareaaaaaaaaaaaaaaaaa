extends CharacterBody2D

var speed = 1000
var gravity = 0
var fake_scale = 1

var jump_height = 1000

func _ready() -> void:
	$attack1.monitoring = false

func _physics_process(delta: float) -> void:
	
	if $AnimationPlayer.current_animation == "attack":
		if $attack1.monitoring:
			if $attack1.get_overlapping_bodies().size() > 0:
				for bodies in $attack1.get_overlapping_bodies():
					if bodies != self and bodies.has_method("delete_self"):
						#$"..".max_number_of_bots -= 1
						$"..".number_of_bots -= 1
						bodies.delete_self()
	
	elif Input.get_action_strength("attack") >= 1:
		$AnimationPlayer.play("attack")
	
	if Input.get_action_strength("left") >= 1:
		velocity.x = -1 * speed
		if fake_scale != -1:
			scale.x = -1
			fake_scale = -1
	elif Input.get_action_strength("right") >= 1:
		velocity.x = speed
		if fake_scale != 1:
			scale.x = -1
			fake_scale = 1

	else: velocity.x = 0
	
	if Input.get_action_strength("up") >= 1 and $RayCast2D.is_colliding():
		gravity -= jump_height
	
	velocity.y += gravity
	if gravity < 0: gravity += 10
	elif !$RayCast2D.is_colliding():
		gravity += 1
		if gravity < 0: gravity = gravity/10
		
	move_and_slide()
	if $RayCast2D.is_colliding():
		gravity = 0


func hitbox_active():
	$attack1.monitoring = true
	
	
func hitbox_disabled():
	$attack1.monitoring = false
