class_name HurtBoxComponent extends Node

signal damage_taken(damage: int)

@export var hurt_box: Area2D

func _ready() -> void:
	hurt_box.area_entered.connect(collision)

func collision(_body) -> void:
	damage_taken.emit(1)
