extends Node2D

@onready var wizards: Node = %Wizards

@onready var all_buttons = [
	$GridContainer/Button1,
	$GridContainer/Button2,
	$GridContainer/Button3,
	$GridContainer/Button4,
	$GridContainer/Button5,
	$GridContainer/Button6,
	$GridContainer/Button7,
	$GridContainer/Button8,
	$GridContainer/Button9,
	$GridContainer/Button10,
	$GridContainer/Button11,
	$GridContainer/Button12,
	$GridContainer/Button13,
	$GridContainer/Button14,
	$GridContainer/Button15,
	$GridContainer/Button16,
	$GridContainer/Button17,
	$GridContainer/Button18,
	$GridContainer/Button19,
	$GridContainer/Button20,
	$GridContainer/Button21,
	$GridContainer/Button22,
	$GridContainer/Button23,
	$GridContainer/Button24,
	$GridContainer/Button25,
	$GridContainer/Button26,
	$GridContainer/Button27,
	$GridContainer/Button28,
	$GridContainer/Button29,
	$GridContainer/Button30,
	$GridContainer/Button31,
	$GridContainer/Button32,
	$GridContainer/Button33,
	$GridContainer/Button34,
	$GridContainer/Button35,
	$GridContainer/Button36,
	$GridContainer/Button37,
	$GridContainer/Button38,
	$GridContainer/Button39,
	$GridContainer/Button40
	]

var button_number: Dictionary # column = x, row = y.

const ALL_LANES = ["lane_1", "lane_2", "lane_3", "lane_4", "lane_5"]

@onready var lane_locations: Dictionary = {
	"lane_1" = $"GridContainer/Button1".global_position.y + $"GridContainer/Button1".size.y / 2,
	"lane_2" = $"GridContainer/Button9".global_position.y + $"GridContainer/Button9".size.y / 2,
	"lane_3" = $"GridContainer/Button17".global_position.y + $"GridContainer/Button17".size.y / 2,
	"lane_4" = $"GridContainer/Button25".global_position.y + $"GridContainer/Button25".size.y / 2,
	"lane_5" = $"GridContainer/Button33".global_position.y + $"GridContainer/Button33".size.y / 2
	}

func get_random_lane():
	lane_locations = {
		"lane_1" = $"GridContainer/Button1".global_position.y + $"GridContainer/Button1".size.y / 2,
		"lane_2" = $"GridContainer/Button9".global_position.y + $"GridContainer/Button9".size.y / 2,
		"lane_3" = $"GridContainer/Button17".global_position.y + $"GridContainer/Button17".size.y / 2,
		"lane_4" = $"GridContainer/Button25".global_position.y + $"GridContainer/Button25".size.y / 2,
		"lane_5" = $"GridContainer/Button33".global_position.y + $"GridContainer/Button33".size.y / 2}
	return(lane_locations[ALL_LANES.pick_random()])

func _button_pressed():
	# Find the pressed button. Let's hope two aren't pressed at the same time!
	var current_button: Button
	for x in all_buttons:
		if x.button_pressed:
			current_button = x
			break
	button_number = {"column" = current_button.get_meta("column"), "row" = current_button.get_meta("row")}
	
	# Prevents multiple wizards from being placed on the same location. 
	var create_new_wizard: bool = true
	for x in wizards.get_children():
		if button_number == x.grid_location:
			create_new_wizard = false
			break
		else:
			create_new_wizard = true

	# Create wizard.
	if create_new_wizard:
		wizards._create_new_wizard(current_button, button_number)
		print(button_number)
	else:
		print("Wizard already there!")
