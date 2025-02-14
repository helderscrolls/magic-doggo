extends Button

@onready var backgroundSprite: Sprite2D = $Background
@onready var centerContainer: CenterContainer = $CenterContainer
@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")

var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroundSprite.frame = 1
	centerContainer.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot or inventory.slots[index] == itemStackGui.inventorySlot:
		return
		
	inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem():
	var item = itemStackGui
	
	inventory.removeSlot(itemStackGui.inventorySlot)
	
	return item

func isEmpty():
	return !itemStackGui

func clear() -> void:
	if itemStackGui:
		centerContainer.remove_child(itemStackGui)
		itemStackGui = null
	
	backgroundSprite.frame = 0
