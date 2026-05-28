extends Node2D


func _ready() -> void:
	EventBus.spawn.connect(_on_spawn)

func _on_spawn(UnitData):
	var unit = preload("res://Units/player_footman.tscn").instantiate()
	unit.unit_data = UnitData
	unit.position = Vector2(0, 0)
	get_parent().add_child(unit)
	print(unit.unit_data.name)
