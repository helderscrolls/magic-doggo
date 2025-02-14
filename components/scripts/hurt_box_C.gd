class_name HurtBoxC extends Node

signal damage_taken

@export var area2D: Area2D

func _ready() -> void:
	area2D.area_entered.connect(collision)

func collision() -> void:
	damage_taken.emit(1)
