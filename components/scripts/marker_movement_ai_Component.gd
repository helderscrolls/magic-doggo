class_name MarkerMovementAiComponent extends Node

@export var limit = 0.5
@export var speed = 20
@export var end_point: Marker2D = null
@export var healthComponent: HealthComponent

@onready var parent: CharacterBody2D = get_parent()

var start_position
var end_position

func _ready() -> void:
	healthComponent.died.connect(disable)
	
	end_point = parent.get_node_or_null("Marker2D")
	start_position = parent.position
	
	if !end_point:
		end_position = start_position + Vector2(0, 32)
		return
	
	end_position = end_point.global_position

func _physics_process(delta: float) -> void:
	update_velocity()
	parent.move_and_slide()

func change_direction() -> void:
	var temporary_end_position = end_position
	
	end_position = start_position
	start_position = temporary_end_position

func update_velocity() -> void:
	var move_direction = end_position - parent.position
	
	if move_direction.length() < limit:
		change_direction()
		
	parent.velocity = move_direction.normalized() * speed

func disable() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
