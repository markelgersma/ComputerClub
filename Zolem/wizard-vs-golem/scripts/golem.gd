extends Area2D

@export_group("Stats")
@export var speed: float = 64
@export var health: float = 100
@export var weaknesses: Array = []
@export var damage: float = 10

@export_group("Randomness")
@export var speed_high: float = 1
@export var speed_low: float = 0.9

func _ready() -> void:
	speed *= randf_range(speed_high, speed_low)

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta # Moves left.

func _take_damage(dealt_damage: float, damage_types: Array):
	for x in weaknesses: # Goes through all weaknesses. 
		if damage_types.has(x): # Double damage if the recieved damage_types has any weakness. 
			dealt_damage *= 2
	health -= dealt_damage # Take damage away. 
	if health <= 0: # Kill golem if health is less than 0. 
		queue_free()
