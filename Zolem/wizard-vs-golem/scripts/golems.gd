extends Node

@onready var scene_parent: Node2D = $".."

const GOLEM = preload("res://scenes/golems/golem.tscn")

func _physics_process(delta: float) -> void:
	if randf() > 0.99: # Temp spawning method. Number pulled out of ass. 
		print("Creating new golem.")
		var new_golem = GOLEM.instantiate() # Instantiates a new golem. 
		new_golem.global_position = Vector2(2000, scene_parent.get_random_lane()) # Moves the golem to its location.  
		add_child(new_golem) # Add child to golems. 
		
