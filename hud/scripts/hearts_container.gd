extends HBoxContainer

@onready var HeartHudScene = preload("res://hud/scenes/heart_hud.tscn")

# Initializes the heart containers based on the maximum health.
func set_max_hearts(max_health: int) -> void:
	var total_hearts = max_health / 4
	
	for _i in range(total_hearts):
		var heart = HeartHudScene.instantiate()
		add_child(heart)

# Updates the hearts' appearance based on the current health.
func update_hearts(current_health: int) -> void:
	var hearts = get_children()
	var filled_hearts = current_health / 4
	
	# Fill in fully filled hearts
	for i in range(filled_hearts):
		hearts[i].update(4)
	
	# If all hearts are fully filled, return early
	if filled_hearts == hearts.size():
		return
	
	# Update the heart with the remaining partial fill
	var remainder = current_health % 4
	hearts[filled_hearts].update(remainder)

	# Set remaining hearts to empty
	for i in range(filled_hearts + 1, hearts.size()):
		hearts[i].update(0)
