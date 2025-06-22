extends CharacterBody2D

var nano_type
var nano_home
var nano_size_x
var nano_size_y



var direction = Vector2.ZERO

var speed = 100

var mode = "AWAY"

var spin_dir = 0 #0 = -, 1 = +

func _ready() -> void:
	spin_dir = randi_range(0,1)
	move_randomly()

func _physics_process(delta: float) -> void:
	if spin_dir == 0: rotation -= 0.2
	else: rotation += 0.2
	if rotation > 360.0 or rotation < -360.0:
		rotation = 0.0
		spin_dir = randi_range(0,1)
	if mode == "RETURN":
		var point_towards = nano_home - global_position
		direction = point_towards.normalized()
	
	
	velocity = direction * speed
	move_and_slide()
	if position.x > nano_home.x + nano_size_x or position.x < nano_home.x - nano_size_x or position.y > nano_home.y + nano_size_y or position.y < nano_home.y - nano_size_y:
		mode = "RETURN"
	if position.distance_to(nano_home) < 10:
		mode = "AWAY"
		move_randomly()
		
	print(mode)


func move_randomly():
	#if randi_range(1, 10) != 0:
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
	#else:
		#var point_towards = nano_home - global_position
		#direction = -1 * point_towards.normalized()
			
			
func _on_timer_timeout() -> void:
	if mode == "AWAY":
		move_randomly()
