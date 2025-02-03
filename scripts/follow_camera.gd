extends Camera2D

@export var groundTileMapLayer: TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mapRect = groundTileMapLayer.get_used_rect()
	var tileSize = groundTileMapLayer.rendering_quadrant_size
	var worldSizeInPixels = mapRect.size * tileSize
	
	limit_right = worldSizeInPixels.x
	limit_bottom = worldSizeInPixels.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
