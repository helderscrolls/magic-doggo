extends CharacterBody2D

@export var knockback_force: int = 250
@export var knockback_duration: float = 0.3

@onready var animations = $AnimationPlayer
@onready var knockback_timer = $Knockbacktimer

var isDead: bool = false

func _ready() -> void:
	knockback_timer.wait_time = knockback_duration	

func _physics_process(delta: float) -> void:
	if isDead:
		return

	updateAnimation()

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		
		if velocity.x < 0:
			direction = "Left"
		elif velocity.x > 0:
			direction = "Right"
		elif velocity.y < 0:
			direction = "Up"
	
		animations.play("walk" + direction)

func is_dead(area) -> void:
	isDead = true
	
	apply_knockback(area.get_parent())
	
	knockback_timer.start()
	await knockback_timer.timeout
	
	animations.play("death")
	await animations.animation_finished
	
	queue_free()

func apply_knockback(attacker: Node2D):
	var knockback_direction = (global_position - attacker.global_position).normalized()
	velocity = knockback_direction * knockback_force
	move_and_slide()
