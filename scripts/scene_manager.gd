extends Node

var player: Player
var scene_dir_path = "res://scenes/"
var previous_scene_name: String

func transition_to_scene(current_scene, next_scene_name: String) -> void:
	previous_scene_name = current_scene.name
	player = current_scene.player
	player.get_parent().remove_child(player)
	
	var full_path = scene_dir_path + next_scene_name + ".tscn"
	
	current_scene.get_tree().call_deferred("change_scene_to_file", full_path)
