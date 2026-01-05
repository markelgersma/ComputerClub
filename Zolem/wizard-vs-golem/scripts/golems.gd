extends Node

@onready var scene_parent: Node2D = $".."

const GOLEM = preload("res://scenes/golems/golem.tscn")
const FIRE_GOLEM = preload("uid://12p6485o2dj8")

const ALL_GOLEMS : Array[PackedScene] = [
	GOLEM, FIRE_GOLEM
]

func _physics_process(delta: float) -> void:
	if randf() > 0.99: # Temp spawning method. Number pulled out of air. 
		print("Creating new golem.")
		var new_golem = ALL_GOLEMS.pick_random().instantiate() # Instantiates a new golem. 
		new_golem.global_position = Vector2(2000, scene_parent.get_random_lane()) # Moves the golem to its location.  
		add_child(new_golem) # Add child to golems.
