extends HBoxContainer

@onready var HeartHudClass = preload("res://scenes/heart_hud.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMaxHearts(maxHearts: int):
	for hearts in range(maxHearts):
		var heart = HeartHudClass.instantiate()
		
		add_child(heart)

func updateHearts(currentHealth: int):
	var hearts = get_children()
	
	for health in range(currentHealth):
		hearts[health].update(true)
		
	for health in range(currentHealth, hearts.size()):
		hearts[health].update(false)
		
