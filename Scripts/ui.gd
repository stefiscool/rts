extends CanvasLayer

func _process(_delta: float) -> void:
	if Global.mana == Global.maxMana:
		$ManaLabel.text = "MANA FULL!"
	else:
		$ManaLabel.text = str(Global.mana) + " Mana"
	$ColorRect6.scale.x = float(Global.mana)/float(Global.maxMana)
	$"Game Paused".visible = Global.paused
	$ColorRect/Label.text = "General Ludendorff of the Fortem Imperium: " + str(Global.generalHealth) + " HP \nGeneral Obsidian of the 3rd Noctean Necromancer: " + str(Global.enemyGeneralHealth) + "HP"
	$ColorRect/PlayerHP.scale.x = Global.generalHealth / 500.0
	$ColorRect/EnemyHP.scale.x = Global.enemyGeneralHealth / 500.0
	$Description/Panel/UnitName.text = Global.unitDict[Global.currentDescUnit]["unitName"]
	$Description/Panel/Stats.text = "Health: " + str(Global.unitDict[Global.currentDescUnit]["maxHp"]) \
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
	$Description.visible = Global.descOpen
	
	
	for i in range(0, Global.unitList.size()):
		if Input.is_action_just_pressed(str(i)):
			Global.currentUnit = Global.unitList[i]
			break


func _on_exit_pressed() -> void:
	Global.descOpen = false
