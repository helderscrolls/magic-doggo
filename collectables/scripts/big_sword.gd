extends "res://collectables/scripts/collectable.gd"

@onready var animations = $AnimationPlayer

func collect(inventory: Inventory):
	animations.play("spin")
	
	await animations.animation_finished
	super.collect(inventory)
