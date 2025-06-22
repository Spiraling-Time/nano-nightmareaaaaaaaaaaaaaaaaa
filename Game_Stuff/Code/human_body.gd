extends Node2D


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
	#distribution.append(Vector3(torso.position, $body/torso/ColorRect.size.x/2, $body/torso/ColorRect.size.y/2))
	pass

func _process(delta: float) -> void:
	position.x += randi_range(50,-50)
