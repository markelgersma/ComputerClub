extends Area2D

# Global nodes
#@onready var spell_container: Node = %Spells # Where all spells are kept. 
@onready var spell_container: Node = $"../../Spells"

# Nodes part of wizard
@onready var attack_timer: Timer = $"Attack Timer" # A timer node, will use _on_attack_timer_timeout when finished. 
@onready var spell_spawn_position: Node2D = $"Spell Spawn Position" # Move this node to where the spell is cast from. 

# Other Variables
var grid_location: Dictionary

@export_group("Stats")
@export var health: float = 100

@export_group("Attacking")
@export var damage: float = 10 # Damage the spell deals.
@export var damage_types: Array[Enums.Element] = [] # Types of damage the spell deals.
@export var spell_speed: float = 256 # Speed the spell travels at.
@export var wizard_casting_speed: float = 2 # Speed the wizard can cast spells in seconds.
@export var spell: PackedScene = preload("res://scenes/spells/attacking_spell.tscn") # The scene that the wizard instantiates on attack. 

@export_group("Randomness")
@export var damage_mult_high: float = 1
@export var damage_mult_low: float = 0.9
@export var spell_speed_mult_high: float = 1
@export var spell_speed_mult_low: float = 0.9
@export var wizard_casting_speed_high: float = 1
@export var wizard_casting_speed_low: float = 0.9

func _ready() -> void: # Called when the scene is created, used for setting timers and stuff correctly. 
	attack_timer.wait_time = wizard_casting_speed # Sets the attack timer to the attack_speed. 
	attack_timer.start() # Put at end of _ready function. 

func _use_attack(): # Gets the wizard to attack.
	print("Wizard is creating attack.")
	attack_timer.wait_time = wizard_casting_speed * randf_range(wizard_casting_speed_high, wizard_casting_speed_low) # Resets the wait_time for an attack in case something has changed. 
	var new_spell = spell.instantiate() # Instantiates a new spell. 
	new_spell.damage = damage * randf_range(damage_mult_low, damage_mult_high) # Sets new spell's damage. 
	new_spell.damage_types = damage_types # Sets new spell's damage types. 
	new_spell.speed = spell_speed * randf_range(spell_speed_mult_low, spell_speed_mult_high) # Sets new spell's speed. 
	new_spell.global_position = spell_spawn_position.global_position # Sets new spell's global position. 
	spell_container.add_child(new_spell) # Adds the spell to where all spells are kept. This wizard can now perish and the spell will not be destroyed. 
	print("Wizard finished creating an attack.")

func _on_attack_timer_timeout() -> void: # Attack timer times out. 
	_use_attack()

func _perish():
	queue_free()
