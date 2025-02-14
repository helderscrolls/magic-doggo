class_name BaseScene extends Node

@onready var player: Player = $Player
@onready var entrance_markets: Node2D = $EntranceMarkers

func _ready() -> void:
	if scene_manager.player:
		if player:
			player.queue_free()
		
		player = scene_manager.player
		add_child(player)
	
	position_player()

func position_player() -> void:
	var last_scene = scene_manager.last_scene_name
	
	if last_scene.is_empty():
		last_scene = "Any"
	
	for entrance in entrance_markets.get_children():
		if entrance is Marker2D and entrance.name == "Any" or entrance.name == last_scene:
			player.global_position = entrance.global_position
	
