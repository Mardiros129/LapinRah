extends Node2D

@onready var camera = $Camera2D
@export var camera_speed = 5

func _unhandled_input(event):
	if Input.is_action_pressed("Exit"):
		get_tree().quit()
	
	if Input.is_action_pressed("PanUp"):
		camera.position.y -= camera_speed
	if Input.is_action_pressed("PanDown"):
		camera.position.y += camera_speed
	if Input.is_action_pressed("PanLeft"):
		camera.position.x -= camera_speed
	if Input.is_action_pressed("PanRight"):
		camera.position.x += camera_speed
