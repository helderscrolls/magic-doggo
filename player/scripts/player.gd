class_name Player extends CharacterBody2D

signal healthChanged

@export var speed: int = 35
@onready var animations = $AnimationPlayer
@onready var effects = $Effects
@onready var hurtBox = $HurtBox
@onready var hurtTimer = $HurtTimer
@onready var weapon = $Weapon

@export var maxHealth = 3*4
@onready var currentHealth: int = maxHealth

@export var knockbackPower: int = 500

@export var inventory: Inventory

var lastAnimDirection: String = "Down"
var isHurt: bool = false
var isAttacking: bool = false

func _ready():
	inventory.use_item.connect(use_item)
	effects.play("RESET")
	weapon.disable()
	
func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "HitBox":
				hurtByEnemy(area)

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.has_method("collect"):
		area.collect(inventory)

func _on_hurt_box_area_exited(area: Area2D) -> void:
	pass # Replace with function body.

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
	
	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	animations.play("attack" + lastAnimDirection)
	isAttacking = true
	weapon.enable()
	
	await animations.animation_finished
	
	weapon.disable()
	isAttacking = false
	
func updateAnimation():
	if isAttacking:
		return
	
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
		lastAnimDirection = direction
	
func handleCollision():
	for collisions in get_slide_collision_count():
		var collision = get_slide_collision(collisions)
		var collider = collision.get_collider()

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
		
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	effects.play("hurtBlink")
	hurtTimer.start()
	
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	
	move_and_slide()

func increase_health(amount: int) -> void:
	currentHealth += amount
	currentHealth = min(maxHealth, currentHealth)
	
	healthChanged.emit(currentHealth)
	
func use_item(item: InventoryItem) -> void:
	if not item.can_be_used(self):
		return
	
	item.use(self)
	
	if item.consumable:
		inventory.remove_last_used_item()
