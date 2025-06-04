extends Node

const WIZARD: PackedScene = preload("res://scenes/wizards/wizard.tscn")

func _create_new_wizard(pressed_button: Button, grid_location: Dictionary):
	print("Creating new wizard.")
	var new_wizard = WIZARD.instantiate()
	new_wizard.global_position = pressed_button.global_position + pressed_button.size / 2
	new_wizard.grid_location = grid_location
	add_child(new_wizard)
