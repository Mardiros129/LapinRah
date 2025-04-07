extends Node2D

@onready var camera = $Camera2D



func _unhandled_input(event):
	if Input.is_action_pressed("PanUp"):
		camera.position.y -= 10
	if Input.is_action_pressed("PanDown"):
		camera.position.y += 10
	if Input.is_action_pressed("PanLeft"):
		camera.position.x -= 10
	if Input.is_action_pressed("PanRight"):
		camera.position.x += 10
