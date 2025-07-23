extends RigidBody2D

var speed = 1000
var gravity = 0
var fake_scale = 1

var jump_height = 1000

func _ready() -> void:
	$Robo_leg1.leg_number = 1
	$Robo_leg2.leg_number = 2
