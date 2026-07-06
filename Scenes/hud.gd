extends CanvasLayer


@onready var gold_label: Label = $Panel2/GoldLabel
@onready var FOOTMAN_DATA = preload("uid://uucgbpnkvr3b")
@onready var ARCHER_DATA = preload("uid://qqqain4h0vo1")
@onready var unit_stats_label: Label = $UnitStatsPanel/UnitStatsLabel

var archery_range_cost := 20
var forge_cost := 15

func _ready() -> void:
	gold_label.text = str("Player Gold: ", Globals.player_gold)
	
	EventBus.gold_changed.connect(_on_gold_changed)
	EventBus.buildings_changed.connect(_on_buildings_changed)
	
	$BuildingMenu/HSplitContainer2/ForgeCost.text = str(forge_cost)
	$BuildingMenu/HSplitContainer/RangeCost.text = str(archery_range_cost)
	
	_stats_updated()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Tab"):
		if self.visible == false:
			self.visible = true
		else:
			self.visible = false


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

func _on_buildings_changed(building):
	if building == "archery_range" and Globals.player_gold >= archery_range_cost:
		$SpawnButtons/HSplitContainer2.visible = true
		EventBus.gold_changed.emit(-archery_range_cost)
	if building == "forge" and Globals.player_gold >= forge_cost:
		$UnitStatsPanel.visible = true
		EventBus.gold_changed.emit(-forge_cost)

func _stats_updated():
	unit_stats_label.text = str(FOOTMAN_DATA.name, ": Damage: ", FOOTMAN_DATA.damage, ", Health: ", FOOTMAN_DATA.health, ", Speed: ", FOOTMAN_DATA.speed) + "\n" + str(ARCHER_DATA.name, ": Damage: ", ARCHER_DATA.damage, ", Health: ", ARCHER_DATA.health, ", Speed: ", ARCHER_DATA.speed)

##Need to make footman and archer cost labels update. Building costs as well

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


func _on_range_button_pressed() -> void:
	EventBus.buildings_changed.emit("archery_range")


func _on_forge_button_pressed() -> void:
	EventBus.buildings_changed.emit("forge")
