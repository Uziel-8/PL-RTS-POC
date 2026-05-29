extends Control


@onready var gold_label: Label = $Panel2/GoldLabel

func _ready() -> void:
	gold_label.text = str("Player Gold: ", Globals.player_gold)
	
	EventBus.gold_changed.connect(_on_gold_changed)

func _on_footman_button_pressed() -> void:
	_spawn(Globals.FOOTMAN)

func _on_archer_button_pressed() -> void:
	_spawn(Globals.ARCHER)

func _spawn(unit_data: UnitData):
	if Globals.player_gold >= -unit_data.gold_cost:
		EventBus.spawn.emit(unit_data)

func _on_gold_changed(change: int):
	Globals.player_gold += change
	gold_label.text = str("Player Gold: ", Globals.player_gold)
