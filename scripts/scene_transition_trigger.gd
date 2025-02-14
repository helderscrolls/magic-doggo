class_name SceneTransitionTrigger extends Area2D

@export var target_scene: String # name of the scene to load

var scene_folder = "res://scenes/"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		scene_manager.transition_to_scene(get_owner(), target_scene)
