extends CharacterBody2D

var nano_type
var nano_home

var direction = Vector2.ZERO

var speed = 100

var mode = "AWAY"

func _physics_process(delta: float) -> void:
	if nano_type == "TORSO":
		if mode == "AWAY":
			var decide_direction = randi_range(1,8)
			if decide_direction == 1:
				direction = Vector2(1,1)
			if decide_direction == 2:
				direction = Vector2(-1,1)
			if decide_direction == 3:
				direction = Vector2(1,-1)					
			if decide_direction == 4:
				direction = Vector2(-1,-1)
			if decide_direction == 5:
				direction = Vector2(-1,0)
			if decide_direction == 6:
				direction = Vector2(1,0)
			if decide_direction == 7:
				direction = Vector2(0,-1)
			if decide_direction == 8:
				direction = Vector2(0,1)
		elif mode == "RETURN":
			var point_towards = nano_home - global_position
			direction = point_towards.normalized()
	
	
	velocity = direction * speed
	move_and_slide()
	if position.distance_to(nano_home) > 50:
		mode = "RETURN"
	if position.distance_to(nano_home) < 10:
		mode = "AWAY"
	print(mode)
