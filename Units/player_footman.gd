extends CharacterBody2D

enum state_list {
	IDLE,
	WANDER,
	CHASE,
	
}

var state = state_list.WANDER
var target: Node2D = null

@export var speed: float = 100.0
@export var stop_distance: float = 10.0
@export var unit_data: UnitData


@onready var detection_zone: Area2D = $DetectionZone


func _physics_process(delta: float) -> void:
	match state:
		state_list.IDLE:
			velocity = Vector2.ZERO
		state_list.WANDER:
			_wander()
		state_list.CHASE:
			_chase()
	move_and_slide()

func _chase():
	if not is_instance_valid(target):
		state = state_list.WANDER
		return
	
	var direction: Vector2 = global_position.direction_to(target.global_position)
	var distance: float = global_position.distance_to(target.global_position)
	
	if distance > stop_distance:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

func _wander():
	velocity.x = 50.0

func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies") and target == null:
		target = body
		state = state_list.CHASE
		#if body.has_method(take_damage()):
		body.take_damage(unit_data.damage)

func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body == target:
		target == null
		state = state_list.IDLE

func take_damage(damage):
	##this could be componentized
	print(damage)
