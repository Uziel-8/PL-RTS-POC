extends CharacterBody2D

@export var unit_data: UnitData

@onready var health = unit_data.health

func _physics_process(delta: float) -> void:
	velocity.x = -50.0
	
	
	move_and_slide()

func take_damage(damage):
	##this could be componentized
	print(damage, " enemy got hit")
	health -= damage
	print("new health: ", health)
	if health <= 0:
		_die()

func _die():
	self.queue_free()
