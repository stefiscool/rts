extends Area2D

var canPlace = false

@onready var unit = preload("res://Scenes/Units/infantry.tscn")


func _process(delta: float) -> void:
	print(str(Global.onUI))
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("click") and canPlace and (Global.mana >= Global.unitDict[Global.currentUnit]["cost"]):
		$"place unit".play()
		var unitInstance = unit.instantiate()
		unitInstance.position = get_global_mouse_position()
		unitInstance.cost = Global.unitDict[Global.currentUnit]["cost"]
		unitInstance.maxHp = Global.unitDict[Global.currentUnit]["maxHp"]
		unitInstance.maxMorale = Global.unitDict[Global.currentUnit]["maxMorale"]
		unitInstance.unitName = Global.unitDict[Global.currentUnit]["unitName"]
		unitInstance.maxSpeed = Global.unitDict[Global.currentUnit]["maxSpeed"]
		unitInstance.size = Global.unitDict[Global.currentUnit]["size"]
		unitInstance.sprite = Global.unitDict[Global.currentUnit]["sprite"]
		unitInstance.icon = Global.unitDict[Global.currentUnit]["icon"]
		unitInstance.damage = Global.unitDict[Global.currentUnit]["damage"]
		unitInstance.attackSpeed = Global.unitDict[Global.currentUnit]["attackSpeed"]
		unitInstance.meleeWeaponReach = Global.unitDict[Global.currentUnit]["meleeWeaponReach"]
		unitInstance.thrustAmplitude = Global.unitDict[Global.currentUnit]["thrustAmplitude"]
		unitInstance.rangedDamage = Global.unitDict[Global.currentUnit]["rangedDamage"]
		unitInstance.projectileSpeed = Global.unitDict[Global.currentUnit]["projectileSpeed"]
		unitInstance.projectileLife = Global.unitDict[Global.currentUnit]["projectileLife"]
		unitInstance.rangeRadius = Global.unitDict[Global.currentUnit]["rangeRadius"]
		unitInstance.rateOfFire = Global.unitDict[Global.currentUnit]["rateOfFire"]
		unitInstance.isMelee = Global.unitDict[Global.currentUnit]["isMelee"]
		unitInstance.isRanged = Global.unitDict[Global.currentUnit]["isRanged"]
		unitInstance.skills = Global.unitDict[Global.currentUnit]["skills"]
		unitInstance.conditions = Global.unitDict[Global.currentUnit]["conditions"]
		get_tree().get_root().add_child(unitInstance)
		Global.mana -= Global.unitDict[Global.currentUnit]["cost"]
	elif Input.is_action_just_pressed("click") and Global.onUI == false:
		$"not enough mana".play()
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Territory"):
		canPlace = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Territory"):
		canPlace = false

		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ally") or body.is_in_group("Enemy"):
		canPlace = false
	
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Ally") or body.is_in_group("Enemy"):
		canPlace = true
