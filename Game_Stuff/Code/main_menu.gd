extends Node2D

@onready var picture = $Sprite2D
@onready var buttons = $"main buttons"
@onready var exit = $Exit

@onready var muse = $AudioStreamPlayer

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	muse.play()


func _on_controls_pressed() -> void:
	picture.frame = 1
	buttons.visible = false
	exit.visible = true


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Game_Stuff/Scenes/world.tscn")


func _on_credits_pressed() -> void:
	picture.frame = 2
	buttons.visible = false
	exit.visible = true


func _on_exit_pressed() -> void:
	picture.frame = 0
	buttons.visible = true
	exit.visible = false


func _on_audio_stream_player_2d_finished() -> void:
	muse.play()
