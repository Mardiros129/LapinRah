extends CharacterBody2D

signal unit_selected
signal unit_deselected

@onready var hovered = false
@onready var is_selected = false
@onready var preparing_attack = false

@onready var destination: Vector2
@export var speed = 50000

@onready var hover_circle = $HoverCircle
@onready var select_circle = $SelectCircle
@onready var attack_circle = $AttackCircle

@onready var state

enum {
	STAND,
	MOVE,
	ATTACK_MOVE,
	ATTACK
}


func _ready():
	destination = global_position
	state = STAND


func _process(delta):
	if state == MOVE or state == ATTACK_MOVE:
		# Checks if the unit is close to the destination, not exactly on it. Prevents jittering.
		if (destination.x - 1 < global_position.x and destination.x + 1 > global_position.x) and (destination.y - 1 < global_position.y and destination.y + 1 > global_position.y):
			state = STAND
		else:
			velocity = (destination - global_position).normalized() * speed * delta
			move_and_slide()


func _unhandled_input(event):
	if Input.is_action_just_pressed("ClickSelect") and hovered:
		if !is_selected:
			select()
		else:
			deselect()


func move(target):
	destination = target
	attack_circle.hide()
	state = MOVE


func attack_move():
	destination = get_global_mouse_position()
	state = ATTACK_MOVE


func attack_startup():
	attack_circle.show()
	preparing_attack = true


func select():
	is_selected = true
	select_circle.show()
	unit_selected.emit(self)


func deselect():
	is_selected = false
	select_circle.hide()
	unit_deselected.emit(self)


func _on_mouse_entered():
	hovered = true
	hover_circle.show()


func _on_mouse_exited():
	hovered = false
	hover_circle.hide()
