extends Node2D


var canPlace = false
@onready var unit = preload("res://Scenes/Units/infantry.tscn")
func _ready() -> void:
	while true:
		if (Global.enemyMana >= Global.unitDict[Global.currentEnemyUnit]["cost"]):
			var i = randi_range(0,9)
			Global.currentEnemyUnit =  Global.enemyUnitList[i]
			Global.enemyMana -= Global.unitDict[Global.currentEnemyUnit]["cost"]
			canPlace = true
		await get_tree().create_timer(randf_range(0.1,5.0)).timeout
		
func _process(delta: float) -> void:
	if canPlace:
		var unitInstance = unit.instantiate()
		unitInstance.position = get_global_position()
		unitInstance.cost = Global.unitDict[Global.currentEnemyUnit]["cost"]
		unitInstance.maxHp = Global.unitDict[Global.currentEnemyUnit]["maxHp"]
		unitInstance.maxMorale = Global.unitDict[Global.currentEnemyUnit]["maxMorale"]
		unitInstance.unitName = Global.unitDict[Global.currentEnemyUnit]["unitName"]
		unitInstance.maxSpeed = Global.unitDict[Global.currentEnemyUnit]["maxSpeed"]
		unitInstance.size = Global.unitDict[Global.currentEnemyUnit]["size"]
		unitInstance.sprite = Global.unitDict[Global.currentEnemyUnit]["sprite"]
		unitInstance.icon = Global.unitDict[Global.currentEnemyUnit]["icon"]
		unitInstance.damage = Global.unitDict[Global.currentEnemyUnit]["damage"]
		unitInstance.attackSpeed = Global.unitDict[Global.currentEnemyUnit]["attackSpeed"]
		unitInstance.meleeWeaponReach = Global.unitDict[Global.currentEnemyUnit]["meleeWeaponReach"]
		unitInstance.thrustAmplitude = Global.unitDict[Global.currentEnemyUnit]["thrustAmplitude"]
		unitInstance.rangedDamage = Global.unitDict[Global.currentEnemyUnit]["rangedDamage"]
		unitInstance.projectileSpeed = Global.unitDict[Global.currentEnemyUnit]["projectileSpeed"]
		unitInstance.projectileLife = Global.unitDict[Global.currentEnemyUnit]["projectileLife"]
		unitInstance.rangeRadius = Global.unitDict[Global.currentEnemyUnit]["rangeRadius"]
		unitInstance.rateOfFire = Global.unitDict[Global.currentEnemyUnit]["rateOfFire"]
		unitInstance.isMelee = Global.unitDict[Global.currentEnemyUnit]["isMelee"]
		unitInstance.isRanged = Global.unitDict[Global.currentEnemyUnit]["isRanged"]
		unitInstance.skills = Global.unitDict[Global.currentEnemyUnit]["skills"]
		unitInstance.conditions = Global.unitDict[Global.currentEnemyUnit]["conditions"]
		unitInstance.isEnemy = true
		get_tree().get_root().add_child(unitInstance)
		canPlace = false
