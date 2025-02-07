extends Control

signal opened
signal closed

var isOpen: bool = false

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready() -> void:
	inventory.updated.connect(update)
	update()

func update():
	for slot_index in range(min(inventory.items.size(), slots.size())):
		var item = inventory.items[slot_index]
		
		slots[slot_index].update(item)

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
