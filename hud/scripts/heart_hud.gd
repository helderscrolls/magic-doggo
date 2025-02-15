extends Panel

@onready var sprite: Sprite2D = $Sprite2D

const MAX_HEART_FRAMES := 4  # Number of frames representing heart states (empty to full)

# Updates the heart sprite frame based on the health fraction (0 to MAX_HEART_FRAMES).
func update(fraction: int) -> void:
	sprite.frame = clamp(fraction, 0, MAX_HEART_FRAMES)
