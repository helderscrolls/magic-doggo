class_name HealthComponent extends Node

signal died

@export var health: int = 1
@export var hurt_box_component: HurtBoxComponent

func _ready() -> void:
	hurt_box_component.damage_taken.connect(damage_taken)

func damage_taken(damage: int) -> void:
	health -= damage
	
	if health <= 0:
		died.emit()
