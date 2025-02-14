extends Resource

class_name InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmountPerStack: int
@export var consumable: bool = true

func use(player: Player) -> void:
	pass

func can_be_used(player: Player) -> bool:
	return true
