extends CharacterBody2D

@export var unit_data: UnitData

@onready var health = unit_data.health

func _physics_process(delta: float) -> void:
	velocity.x = -50.0
	
	
	move_and_slide()

func take_damage(damage, knockback):
	##this could be componentized
	print(damage, " enemy got hit")
	health -= damage
	print("new health: ", health)
	print("Knockback: ", knockback)
	##MAKE THE BELOW LESS SHIT
	position.x += knockback
	if health <= 0:
		_die()

func _die():
	EventBus.gold_changed.emit(unit_data.gold_bounty)
	self.queue_free()
