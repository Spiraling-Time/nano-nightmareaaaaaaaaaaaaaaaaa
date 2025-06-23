extends CharacterBody2D

var nano_type
var nano_home
var nano_size_x
var nano_size_y

var nano_thingIcantthinkofname

var direction = Vector2.ZERO

var speed = 100

var mode = "AWAY"

var spin_dir = 0 #0 = -, 1 = +

var nano_illusion

var randiii


@onready var contact = $Contact

func _ready() -> void:
	if nano_type == "TORSO": nano_thingIcantthinkofname = $"../human_body/body/torso"
	elif nano_type == "HEAD": nano_thingIcantthinkofname = $"../human_body/body/head"
	elif nano_type == "UPPER_ARM1": nano_thingIcantthinkofname = $"../human_body/body/upper_arm1"
	elif nano_type == "LOWER_ARM1": nano_thingIcantthinkofname = $"../human_body/body/lower_arm1"
	elif nano_type == "UPPER_ARM2": nano_thingIcantthinkofname = $"../human_body/body/upper_arm2"
	elif nano_type == "LOWER_ARM2": nano_thingIcantthinkofname = $"../human_body/body/lower_arm2"
	elif nano_type == "UPPER_LEG1": nano_thingIcantthinkofname = $"../human_body/body/upper_leg1"
	elif nano_type == "LOWER_LEG1": nano_thingIcantthinkofname = $"../human_body/body/lower_leg1"
	elif nano_type == "UPPER_LEG2": nano_thingIcantthinkofname = $"../human_body/body/upper_leg2"
	elif nano_type == "LOWER_LEG2": nano_thingIcantthinkofname = $"../human_body/body/lower_leg2"

	spin_dir = randi_range(0,1)
	randiii = randi_range(1,4)
	if randiii == 1:
		nano_illusion = preload("res://Game_Stuff/Assets/Nano Nightmare art.png")
		$CollisionShape2D4.disabled = true
		$CollisionShape2D5.disabled = true
		$CollisionShape2D2.disabled = true
		$CollisionShape2D3.disabled = true
		$CollisionShape2D6.disabled = true
		$CollisionShape2D7.disabled = true

		
	elif randiii == 2:
		nano_illusion = preload("res://Game_Stuff/Assets/Nano Nightmare art (1).png")
		$CollisionShape2D6.disabled = true
		$CollisionShape2D7.disabled = true


	elif randiii == 3:
		nano_illusion = preload("res://Game_Stuff/Assets/Nano Nightmare art (2).png")
		$CollisionShape2D.disabled = true
		$CollisionShape2D4.disabled = true
		$CollisionShape2D5.disabled = true
		$CollisionShape2D2.disabled = true
		$CollisionShape2D3.disabled = true
	
	
	else:
		nano_illusion = preload("res://Game_Stuff/Assets/Nano Nightmare art (3).png")
		$CollisionShape2D4.disabled = true
		$CollisionShape2D5.disabled = true
		$CollisionShape2D6.disabled = true
		$CollisionShape2D7.disabled = true
	
	
	$Sprite2D.texture = nano_illusion
	
	$Timer.start()
	
func _physics_process(delta: float) -> void:

	
	
	if randiii != 1:
		if spin_dir == 0: rotation -= 0.2
		else: rotation += 0.2
		if rotation > 360.0 or rotation < -360.0:
			rotation = 0.0
			spin_dir = randi_range(0,1)
	if mode == "RETURN":
		var point_towards = Vector2.ZERO
		point_towards = nano_thingIcantthinkofname.global_position - global_position
		direction = point_towards.normalized()

	#if direction == Vector2.ZERO: move_randomly()
	
	velocity = direction * speed

	
	move_and_slide()
	
	if position.x > nano_thingIcantthinkofname.global_position.x + nano_size_x or position.x < nano_thingIcantthinkofname.global_position.x - nano_size_x or position.y > nano_thingIcantthinkofname.global_position.y + nano_size_y or position.y < nano_thingIcantthinkofname.global_position.y - nano_size_y:
		mode = "RETURN"
	else: #if position.distance_to(nano_thingIcantthinkofname.global_position) <= 101: #MAKE THIS ELSE IF THERE ARE PROBLEMS
		mode = "AWAY"
		$Timer.start()
		move_randomly()
		
	#print(mode)


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

func _on_timer_timeout() -> void:
	if mode == "AWAY":
		$Timer.start()
		move_randomly()
