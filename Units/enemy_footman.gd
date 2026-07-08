extends CharacterBody2D

@export var unit_data: UnitData
@export var goal: Node = null
@onready var health = unit_data.health

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D


signal died

func _ready() -> void:
	nav_agent.target_position = goal.global_position



func _physics_process(delta: float) -> void:
	if !nav_agent.is_target_reached():
		var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = nav_point_direction * unit_data.speed
	
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
	died.emit()


func _on_nav_timer_timeout() -> void:
	#if goal == null:
		#for scene in get_tree():
			#if scene.is_in_group("PlayerUnits"):
				#goal = scene
	if nav_agent.target_position != goal.global_position:
		nav_agent.target_position = goal.global_position
	$NavTimer.start()
