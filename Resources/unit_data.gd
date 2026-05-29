extends Resource

class_name UnitData

@export var name: String
@export var description: String
@export var health: int
@export var damage: int
@export var knockback: float
@export var is_ranged: bool = false
@export var speed: float

@export var gold_cost: int ##how much they cost to build, needs to be negative
@export var gold_bounty: int ##this one is how much they are worth to kill
