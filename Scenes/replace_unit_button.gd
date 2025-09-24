extends Button

var unitName = "Barbados"
#
#func _ready() -> void:
	
func _process(_delta: float) -> void:
	text = unitName
	icon = Global.unitDict[unitName]["icon"]
	$ColorRect/ColorRect2/Label.text = str(Global.unitDict[unitName]["cost"]) + "M"
	
func _on_stats_button_pressed() -> void:
	if Global.desc2Open and Global.currentDescUnit2 == unitName:
		Global.desc2Open = false
	else:
		Global.desc2Open = true
		Global.currentDescUnit2 = unitName


func _on_pressed() -> void:
	var temp = Global.replacingUnit
	var index_to_replace = Global.unitList.find(Global.replacingUnit)
	if index_to_replace != -1:
		Global.unitList[index_to_replace] = unitName
	var index_to_replace2 = Global.inventory.find(unitName)
	if index_to_replace2 != -1:
		Global.inventory[index_to_replace2] = Global.replacingUnit
	unitName = temp
	Global.desc2Open = false
	Global.descOpen = false
	Global.replacing = false
