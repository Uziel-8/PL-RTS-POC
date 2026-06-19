extends Node2D


func _ready() -> void:
	EventBus.spawn.connect(_on_spawn)

func _on_spawn(UnitData):
	var unit = preload("res://Units/player_footman.tscn").instantiate()
	unit.unit_data = UnitData
	unit.position = self.position + Vector2(randi_range(100, -100), randi_range(100, -100))
	get_parent().add_child(unit)
	EventBus.gold_changed.emit(unit.unit_data.gold_cost)
	print(unit.unit_data.name)
