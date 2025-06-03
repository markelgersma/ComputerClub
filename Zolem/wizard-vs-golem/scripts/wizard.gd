extends Node2D

@onready var attack_timer: Timer = $"Attack Timer"

@export_category("Stats")
@export var health: float = 100

@export_category("Attacking")
@export var damage: float = 10
@export var attack_speed: float = 0.25
@export var damage_type: String = "magic"

func _ready() -> void:
	attack_timer.wait_time = attack_speed
