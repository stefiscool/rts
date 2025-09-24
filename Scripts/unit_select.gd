extends Node2D

var replacing = false

func _process(_delta: float) -> void:
	$Description.visible = Global.descOpen
	$Description/Panel/UnitName.text = Global.unitDict[Global.currentDescUnit]["unitName"]
	$Description/Panel/Stats.text = "Health: " + str(Global.unitDict[Global.currentDescUnit]["maxHp"]) \
	+ "\nMana: " + str(Global.unitDict[Global.currentDescUnit]["cost"]) \
	+ "\nMorale: " + str(Global.unitDict[Global.currentDescUnit]["maxMorale"]) \
	+ "\nSpeed: " + str(Global.unitDict[Global.currentDescUnit]["maxSpeed"]) \
	+ ("\nMelee Damage: " + str(Global.unitDict[Global.currentDescUnit]["damage"]) if Global.unitDict[Global.currentDescUnit]["isMelee"] else "") \
	+ ("\nMelee Speed: " + str(Global.unitDict[Global.currentDescUnit]["attackSpeed"]) if Global.unitDict[Global.currentDescUnit]["isMelee"] else "") \
	+ ("\nMelee Reach: " + str(Global.unitDict[Global.currentDescUnit]["meleeWeaponReach"]) if Global.unitDict[Global.currentDescUnit]["isMelee"] else "") \
	+ ("\nRange: " + str(Global.unitDict[Global.currentDescUnit]["rangeRadius"]) if Global.unitDict[Global.currentDescUnit]["isRanged"] else "") \
	+ ("\nRanged Damage: " + str(Global.unitDict[Global.currentDescUnit]["rangedDamage"]) if Global.unitDict[Global.currentDescUnit]["isRanged"] else "") \
	+ ("\nProjectile Speed: " + str(Global.unitDict[Global.currentDescUnit]["projectileSpeed"]) if Global.unitDict[Global.currentDescUnit]["isRanged"] else "") \
	+ ("\nProjectile Life: " + str(Global.unitDict[Global.currentDescUnit]["projectileLife"]) if Global.unitDict[Global.currentDescUnit]["isRanged"] else "") \
	+ ("\nRate of Fire: " + str(Global.unitDict[Global.currentDescUnit]["rateOfFire"]) if Global.unitDict[Global.currentDescUnit]["isRanged"] else "")
	$Description/Panel/Icon.texture = Global.unitDict[Global.currentDescUnit]["icon"]
	$Description/Panel/Desc.text = Global.unitDict[Global.currentDescUnit]["desc"]
	#Description box 2
	$Description2.visible = Global.desc2Open
	$Description2/Panel/UnitName.text = Global.unitDict[Global.currentDescUnit2]["unitName"]
	$Description2/Panel/Stats.text = "Health: " + str(Global.unitDict[Global.currentDescUnit2]["maxHp"]) \
	+ "\nMana: " + str(Global.unitDict[Global.currentDescUnit2]["cost"]) \
	+ "\nMorale: " + str(Global.unitDict[Global.currentDescUnit2]["maxMorale"]) \
	+ "\nSpeed: " + str(Global.unitDict[Global.currentDescUnit2]["maxSpeed"]) \
	+ ("\nMelee Damage: " + str(Global.unitDict[Global.currentDescUnit2]["damage"]) if Global.unitDict[Global.currentDescUnit2]["isMelee"] else "") \
	+ ("\nMelee Speed: " + str(Global.unitDict[Global.currentDescUnit2]["attackSpeed"]) if Global.unitDict[Global.currentDescUnit2]["isMelee"] else "") \
	+ ("\nMelee Reach: " + str(Global.unitDict[Global.currentDescUnit2]["meleeWeaponReach"]) if Global.unitDict[Global.currentDescUnit2]["isMelee"] else "") \
	+ ("\nRange: " + str(Global.unitDict[Global.currentDescUnit2]["rangeRadius"]) if Global.unitDict[Global.currentDescUnit2]["isRanged"] else "") \
	+ ("\nRanged Damage: " + str(Global.unitDict[Global.currentDescUnit2]["rangedDamage"]) if Global.unitDict[Global.currentDescUnit2]["isRanged"] else "") \
	+ ("\nProjectile Speed: " + str(Global.unitDict[Global.currentDescUnit2]["projectileSpeed"]) if Global.unitDict[Global.currentDescUnit2]["isRanged"] else "") \
	+ ("\nProjectile Life: " + str(Global.unitDict[Global.currentDescUnit2]["projectileLife"]) if Global.unitDict[Global.currentDescUnit2]["isRanged"] else "") \
	+ ("\nRate of Fire: " + str(Global.unitDict[Global.currentDescUnit2]["rateOfFire"]) if Global.unitDict[Global.currentDescUnit2]["isRanged"] else "")
	$Description2/Panel/Icon.texture = Global.unitDict[Global.currentDescUnit2]["icon"]
	$Description2/Panel/Desc.text = Global.unitDict[Global.currentDescUnit2]["desc"]


func _on_exit_pressed() -> void:
	Global.descOpen = false


func _on_exit_2_pressed() -> void:
	Global.desc2Open = false
