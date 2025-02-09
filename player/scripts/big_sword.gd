extends Area2D

@onready var collisionShape = $CollisionShape2D

func enable():
	collisionShape.disabled = false

func disable():
	collisionShape.disabled = true
