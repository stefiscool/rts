extends Button

var unitName = "Barbados"

func _ready() -> void:
	text = unitName
	icon = Global.unitDict[unitName]["icon"]
	$ColorRect/ColorRect2/Label.text = str(Global.unitDict[unitName]["cost"]) + "M"
	
func _on_stats_button_pressed() -> void:
	if Global.desc2Open and Global.currentDescUnit2 == unitName:
		Global.desc2Open = false
	else:
		Global.desc2Open = true
		Global.currentDescUnit2 = unitName
