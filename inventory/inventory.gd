extends Resource

class_name Inventory

signal updated
signal use_item

@export var slots: Array[InventorySlot]

var index_of_last_used_item: int = -1

func insert(item: InventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item and slot.amount < item.maxAmountPerStack)

	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1

	updated.emit()

func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0:
		return
	
	remove_at_index(index)

func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	updated.emit()

func use_item_at_index(index: int) -> void:
	if index < 0 or index >= slots.size() or !slots[index].item:
		return
	
	var slot = slots[index]
	index_of_last_used_item = index
	
	use_item.emit(slot.item)
	
func remove_last_used_item() -> void:
	if index_of_last_used_item < 0:
		return
	
	var slot = slots[index_of_last_used_item]
	
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit()
		
		return 
	
	remove_at_index(index_of_last_used_item)
