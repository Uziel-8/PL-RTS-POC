extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer



func _on_spawn_timer_timeout() -> void:
	var unit = preload("res://Units/enemy_footman.tscn").instantiate()
	unit.unit_data = preload("res://Resources/slime_data.tres")
	unit.position = self.position
	get_parent().add_child(unit)
