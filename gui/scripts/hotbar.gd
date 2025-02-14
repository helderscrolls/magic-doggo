extends Panel

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector

var currently_selected: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.updated.connect(update)

func update() -> void:
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_item"):
		inventory.use_item_at_index(currently_selected)
