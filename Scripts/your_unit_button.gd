extends Button

@export var number = 0
var unitName = ""

func _ready() -> void:
	unitName = Global.unitList[number]
	text = unitName
	$ColorRect2/ColorRect2/Label.text = str(number)
	$ColorRect3/ColorRect2/Label.text = str(Global.unitDict[unitName]["cost"]) + "M"
	


func _on_stats_button_pressed() -> void:
	if Global.descOpen and Global.currentDescUnit == unitName:
		Global.descOpen = false
	else:
		Global.descOpen = true
		Global.currentDescUnit = unitName


func _on_pressed() -> void:
	$"../..".replacing = true
	print(str($"../..".replacing))
