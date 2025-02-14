class_name WeaponItem extends InventoryItem

@export var weapon_class: PackedScene = preload("res://player/scenes/big_sword.tscn")

var weapon

func _init() -> void:
	weapon = weapon_class.instantiate()

func use(player: Player) -> void:
	player.weapon.add_weapon(weapon)
	player.weapon.disable()
