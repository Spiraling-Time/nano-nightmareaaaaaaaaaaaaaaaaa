extends Node2D


var speed = 10

var debugging: bool = false

var mode = "IDLE"

var fall_speed = 1

@onready var torso = $body/torso
@onready var head = $body/torso/head
@onready var upper_arm1 = $body/torso/upper_arm1
@onready var lower_arm1 = $body/torso/upper_arm1/lower_arm1
@onready var upper_arm2 = $body/torso/upper_arm2
@onready var lower_arm2 = $body/torso/upper_arm2/lower_arm2
@onready var upper_leg1 = $body/torso/upper_leg1
@onready var lower_leg1 = $body/torso/upper_leg1/lower_leg1
@onready var upper_leg2 = $body/torso/upper_leg2
@onready var lower_leg2 = $body/torso/upper_leg2/lower_leg2

@onready var standing1 = $body/torso/upper_leg1/lower_leg1/standing
@onready var standing2 = $body/torso/upper_leg2/lower_leg2/standing



var distribution: Array = []

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	#position.x = randi_range(0,500)
	#position.x += speed
	#if position.x >1000 or position.x < -100: speed = speed * -1
	if !standing1.is_colliding() and !standing2.is_colliding():
		position.y += fall_speed
		if !standing1.is_colliding() and !standing2.is_colliding():
			fall_speed = fall_speed*1.1
		else:
			position.y -= fall_speed
			fall_speed = 1
	#if mode == "IDLE":
		
