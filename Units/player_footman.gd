extends CharacterBody2D

enum state_list {
	IDLE,
	WANDER,
	CHASE,
	ATTACKING,
	TRANSITION,
}

var state = state_list.WANDER
var target: Node2D = null


@export var stop_distance: float = 10.0
@export var unit_data: UnitData
@export var speed: float = 100.0

@onready var detection_zone: Area2D = $DetectionZone
@onready var attack_cooldown: Timer = $AttackCooldown

@onready var can_attack: bool = true


func _physics_process(delta: float) -> void:
	match state:
		state_list.IDLE:
			velocity = Vector2.ZERO
		state_list.WANDER:
			_wander()
		state_list.CHASE:
			_chase()
		state_list.ATTACKING:
			_attacking()
		state_list.TRANSITION:
			_transition()
	move_and_slide()


func _wander():
	velocity.x = unit_data.speed * 0.5

func _chase():
	if not is_instance_valid(target):
		state = state_list.WANDER
		return
	
	var direction: Vector2 = global_position.direction_to(target.global_position)
	var distance: float = global_position.distance_to(target.global_position)
	
	if distance > stop_distance:
		velocity = direction * unit_data.speed
	else:
		velocity = Vector2.ZERO

func _attacking():
	if not is_instance_valid(target):
		target = null
		state = state_list.TRANSITION
		return
	if can_attack:
		attack_cooldown.start()
		target.take_damage(unit_data.damage, unit_data.knockback)
		can_attack = false

func _transition():
	if detection_zone.has_overlapping_bodies():
		for body in detection_zone.get_overlapping_bodies():
			if body.is_in_group("Enemies") and (target == null or not is_instance_valid(target)):
				target = body
				target.died.connect(_on_target_died, CONNECT_ONE_SHOT)
				state = state_list.CHASE
	else:
		state = state_list.WANDER



func _on_detection_zone_body_entered(body: Node2D) -> void:
	print("detection entered | body: ", body.name, " | target: ", target, " | state: ", state)
	if body.is_in_group("Enemies") and (target == null or not is_instance_valid(target)):
		target = body
		target.died.connect(_on_target_died, CONNECT_ONE_SHOT)
		state = state_list.CHASE

func _on_detection_zone_body_exited(body: Node2D) -> void:
	print("detection exited | body: ", body.name, " | target: ", target)
	if body == target:
		target = null
		state = state_list.WANDER

func _on_attacking_zone_body_entered(body: Node2D) -> void:
	print("attack zone entered | body: ", body.name, " | target: ", target, " | state: ", state)
	if state == state_list.CHASE and body == target:
		state = state_list.ATTACKING

func _on_attacking_zone_body_exited(body: Node2D) -> void:
	if state == state_list.ATTACKING and body == target:
		state = state_list.CHASE



func _on_target_died():
	target = null
	state = state_list.TRANSITION

func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func take_damage(damage, knockback):
	##this could be componentized
	print(damage, " player got hit")
	##add in something for getting knocked back
