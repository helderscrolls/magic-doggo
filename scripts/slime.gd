extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimatedSprite2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	
	# Static - Blocks down movement
	#endPosition = startPosition + Vector2(0, 3*16)
	
	# Dynamic EndPosition
	endPosition = endPoint.global_position
	
func changeDirection():
	var temporaryEndPosition = endPosition
	
	endPosition = startPosition
	startPosition = temporaryEndPosition
	
func updateVelocity():
	var moveDirection = endPosition - position
	
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized() * speed
	
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

func _physics_process(delta: float) -> void:
	updateVelocity()
	move_and_slide()
	updateAnimation()
