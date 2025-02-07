extends Area2D

@export var itemResource: InventoryItem

func collect(inventory: Inventory):
	inventory.insert(itemResource)
	queue_free()
