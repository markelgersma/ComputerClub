extends Area2D

var damage: float # Assigned in the wizard when instantiating.
var damage_types: Array # Assigned in the wizard when instantiating.
var speed: float # Assigned in the wizard when instantiating.

func _physics_process(delta: float) -> void:
	if global_position.x < -100 or global_position.x > 2000: # Spell queue_frees if it is too far to the left or right. 
		print("Spell is out of bounds.")
		queue_free() # Destroy it. 
	else: # The spell is still within boundaries. 
		global_position.x += speed * delta # Changes the spell's x position by speed * delta.

func _on_area_entered(area: Area2D) -> void: # Enters something on the same collision layer as this spell (layer 2 named "Golems")
	area._take_damage(damage, damage_types) # Deals damage to the hit object, passing in a dict with damage and element.
	queue_free() # Destroy the thing.
