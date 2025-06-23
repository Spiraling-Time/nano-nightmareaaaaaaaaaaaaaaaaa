extends Node2D


var speed = 10

var debugging: bool = false

var mode = "IDLE"

@onready var torso = $body/torso
@onready var head = $body/head
@onready var upper_arm1 = $body/upper_arm1
@onready var lower_arm1 = $body/lower_arm1
@onready var upper_arm2 = $body/upper_arm2
@onready var lower_arm2 = $body/lower_arm2
@onready var upper_leg1 = $body/upper_leg1
@onready var lower_leg1 = $body/lower_leg1
@onready var lower_leg2 = $body/lower_leg2

var distribution: Array = []

func _ready() -> void:
	if debugging:
		$body/torso/Sprite2D.visible = true
		$body/head/Sprite2D2.visible = true
		$body/upper_arm1/Sprite2D3.visible = true
		$body/upper_arm1/lower_arm1/Sprite2D4.visible = true
		$body/upper_arm2/Sprite2D5.visible = true
		$body/upper_arm2/lower_arm2/Sprite2D6.visible = true
		$body/upper_leg1/Sprite2D7.visible = true
		$body/upper_leg1/lower_leg1/Sprite2D8.visible = true
		$body/upper_leg2/Sprite2D9.visible = true
		$body/upper_leg2/lower_leg2/Sprite2D10.visible = true


func _process(delta: float) -> void:
	#position.x = randi_range(0,500)
	#position.x += speed
	#if position.x >1000 or position.x < -100: speed = speed * -1
#	if mode == "IDLE":
	pass
