extends Node2D

@onready var selection: Array


func _ready():
	for n in get_children():
		n.unit_selected.connect(_on_unit_selected)
		n.unit_deselected.connect(_on_unit_deselected)
		n.selection_cleared.connect(_on_selection_cleared)


func _unhandled_input(event):
	if Input.is_action_pressed("ClickMove"):
		var mouse_target = get_global_mouse_position()

		### TO DO: move as a group so they don't all cluster together
		if selection.size() > 1:
			var sum = Vector2(0, 0)
			for n in selection:
				sum += n.position
			var average_position = sum / selection.size()
			var offset = mouse_target - average_position
		
			for x in selection:
				var new_target = x.position + offset
				x.move(new_target)
		
		elif selection.size() == 1:
			selection[0].move(mouse_target)


	if Input.is_action_just_pressed("AttackMove"):
		for x in selection:
			x.attack_move()


func _on_unit_selected(unit):
	selection.append(unit)


func _on_unit_deselected(unit):
	selection.erase(unit)

func _on_selection_cleared():
	if selection.size() > 0:
		for n in selection:
			n.deselect()
		selection.clear()
