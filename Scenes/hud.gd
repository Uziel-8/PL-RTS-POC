extends Control


@onready var gold_label: Label = $Panel2/GoldLabel
@onready var FOOTMAN_DATA = preload("uid://uucgbpnkvr3b")
@onready var ARCHER_DATA = preload("uid://qqqain4h0vo1")
@onready var unit_stats_label: Label = $UnitStatsPanel/UnitStatsLabel

func _ready() -> void:
	gold_label.text = str("Player Gold: ", Globals.player_gold)
	
	EventBus.gold_changed.connect(_on_gold_changed)
	
	_stats_updated()

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

func _stats_updated():
	unit_stats_label.text = str(FOOTMAN_DATA.name, ": Damage: ", FOOTMAN_DATA.damage, ", Health: ", FOOTMAN_DATA.health, ", Speed: ", FOOTMAN_DATA.speed) + "\n" + str(ARCHER_DATA.name, ": Damage: ", ARCHER_DATA.damage, ", Health: ", ARCHER_DATA.health, ", Speed: ", ARCHER_DATA.speed)


func _on_upgrade_footmen_pressed() -> void:
	var cost = 10
	if Globals.player_gold >= cost:
		FOOTMAN_DATA.damage += 10
		FOOTMAN_DATA.speed += 10
		EventBus.gold_changed.emit(-cost)
		_stats_updated()

func _on_upgrade_archer_pressed() -> void:
	var cost = 10
	if Globals.player_gold >= cost:
		ARCHER_DATA.damage += 10
		ARCHER_DATA.speed += 10
		EventBus.gold_changed.emit(-cost)
		_stats_updated()
