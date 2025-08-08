extends Area2D

var origin_point
var speed = 2000

@onready var player = $"../player"

func _physics_process(delta: float) -> void:
	if !player.bodysprite.flip_h: position += Vector2.RIGHT.rotated(rotation)*speed*delta
	else: position += Vector2.LEFT.rotated(rotation)*speed*delta
	if position.distance_to(origin_point) >= 2000: queue_free()
	if get_overlapping_bodies().size() >=1:
		for bodies in get_overlapping_bodies():
			if bodies.has_method("delete_self"): bodies.delete_self()
			else: queue_free()
