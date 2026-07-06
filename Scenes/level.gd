extends Node2D

func _ready() -> void:
	EventBus.buildings_changed.connect(_on_buildings_changed)


func _on_buildings_changed(building):
	if building == "archery_range":
		$ArcheryRange.visible = true
	if building == "forge":
		$Forge.visible = true
