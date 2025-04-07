extends CharacterBody2D

@onready var hovered = false
@onready var is_selected = false
@onready var preparing_attack = false

@onready var destination: Vector2
@export var speed = 50000

@onready var hover_circle = $HoverCircle
@onready var select_circle = $SelectCircle
@onready var attack_circle = $AttackCircle


func _ready():
	destination = global_position


func _process(delta):
	if global_position != destination:
		velocity = (destination - global_position).normalized() * speed * delta
		move_and_slide()


func _unhandled_input(event):
	if Input.is_action_just_pressed("ClickMove") && is_selected:
		destination = get_global_mouse_position()
		attack_circle.hide()
	if Input.is_action_just_pressed("AttackMove") && is_selected:
		attack_circle.show()
		preparing_attack = true
	
	if Input.is_action_just_pressed("ClickSelect") && hovered && !is_selected:
		is_selected = true
		select_circle.show()
	elif Input.is_action_just_pressed("ClickSelect") && hovered && is_selected:
		is_selected = false
		select_circle.hide()
	elif Input.is_action_just_pressed("ClickSelect") && preparing_attack:
		destination = get_global_mouse_position()


func _on_mouse_entered():
	hovered = true
	hover_circle.show()


func _on_mouse_exited():
	hovered = false
	hover_circle.hide()
