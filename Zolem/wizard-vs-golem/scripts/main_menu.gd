extends Control


func _on_play_game_pressed() -> void:
	print("Switching scene to play.")
	get_tree().change_scene_to_file("uid://be14i10buvddn") # UID is the Universal IDentifier of a scene. No matter where it goes, its UID will never change. 
