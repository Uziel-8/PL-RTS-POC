extends Control


func _on_footman_button_pressed() -> void:
	_spawn(Globals.FOOTMAN)

func _on_archer_button_pressed() -> void:
	_spawn(Globals.ARCHER)


func _spawn(UnitData):
	EventBus.spawn.emit(UnitData)
