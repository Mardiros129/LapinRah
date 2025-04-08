extends Node2D

@onready var selection: Array


func _ready():
	for n in get_children():
		n.unit_selected.connect(_on_unit_selected)
		n.unit_deselected.connect(_on_unit_deselected)


func _unhandled_input(event):
	if Input.is_action_pressed("ClickMove"):
		var target = get_global_mouse_position()
		
		### TO DO: move as a group so they don't all cluster together
		if selection.size() > 1:
			var temp_sum = Vector2(0, 0)
			for n in selection:
				temp_sum += n.position
			var average_position = temp_sum / selection.size()
			var offset = target - average_position
			target += offset
		### END TO DO
		
		for x in selection:
			x.move(target)


	if Input.is_action_just_pressed("AttackMove"):
		for x in selection:
			x.attack_move()


func _on_unit_selected(unit):
	selection.append(unit)


func _on_unit_deselected(unit):
	selection.erase(unit)
