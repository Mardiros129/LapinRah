extends Node2D

@export var max_hp = 10
@onready var hp: int
@onready var label = $Label


func _ready():
	hp = max_hp
	label.text = str(hp) + "/" + str(max_hp)


func take_damage():
	hp -= 1
