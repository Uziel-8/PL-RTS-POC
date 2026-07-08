extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer
@export var goal: Node = null


func _on_spawn_timer_timeout() -> void:
	var unit = preload("res://Units/enemy_footman.tscn").instantiate()
	unit.unit_data = preload("res://Resources/slime_data.tres")
	unit.position = self.position
	unit.goal = goal
	get_parent().add_child(unit)
