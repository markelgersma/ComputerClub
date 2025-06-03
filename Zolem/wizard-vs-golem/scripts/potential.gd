extends Node2D

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
	$GridContainer/Button40]

var button_number: Dictionary # column = x, row = y.

func _button_pressed():
	var current_button: Button
	for x in all_buttons:
		if x.button_pressed:
			current_button = x
			break
	button_number = {"column" = current_button.get_meta("column"), "row" = current_button.get_meta("row")}
	print(button_number)
