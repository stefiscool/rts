extends Button

@export var unitNumber = 1
var unit = "Imperial Musketeer"

func _ready() -> void:
	unit = Global.unitList[unitNumber]
	$UnitLabel.text = Global.unitDict[unit]["unitName"]
	$UnitNumLabel.text = "(" + str(unitNumber) + ")"
	$ManaLabel.text = str(Global.unitDict[unit]["cost"]) + "M"
	icon = Global.unitDict[unit]["icon"]

func _process(delta: float) -> void:
	$ColorRect2.visible = (unit == Global.currentUnit)
	
func _on_button_pressed() -> void:
	if Global.descOpen and Global.currentDescUnit == unit:
		Global.descOpen = false
	else:
		Global.descOpen = true
		Global.currentDescUnit = unit

func _on_pressed() -> void:
	Global.currentUnit = unit
