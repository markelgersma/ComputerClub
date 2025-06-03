extends Control


func _on_play_game_pressed() -> void:
	print("Switching scene to play.")
	get_tree().change_scene_to_file("res://scenes/potential.tscn")
