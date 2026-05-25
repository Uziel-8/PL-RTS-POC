extends CharacterBody2D

@export var unit_data: UnitData

func _physics_process(delta: float) -> void:
	velocity.x = -50.0
	
	
	move_and_slide()

func take_damage(damage):
	##this could be componentized
	print(damage)
