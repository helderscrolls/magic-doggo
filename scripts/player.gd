extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
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
	
func handleCollision():
	for collisions in get_slide_collision_count():
		var collision = get_slide_collision(collisions)
		var collider = collision.get_collider()
		print_debug(collider.name)	

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "HitBox":
		print_debug(area.get_parent().name)
