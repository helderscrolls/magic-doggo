extends BaseScene

@onready var heartsContainer = $CanvasLayer/HeartsContainer
@onready var follow_camera = $FollowCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	follow_camera.target_to_follow = player
	
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_inventory_gui_closed() -> void:
	get_tree().paused = false


func _on_inventory_gui_opened() -> void:
	get_tree().paused = true
