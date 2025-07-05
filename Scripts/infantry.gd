extends CharacterBody2D

enum State {ATTACK, RETREAT, SKIRMISH}
var currentState = State.ATTACK
@export var cost = 10
@export var maxHp = 100
@export var maxMorale = 50
@export var unitName = "Infantry"
@export var maxSpeed = 200

#These stats only apply to melee units
@export var damage = 10
@export var attackSpeed = 6000 # only applies to units without the "Thrust" skill
@export var meleeWeaponReach = 1.0
@export var thrustAmplitude = 50 # only applies to units with the "Thrust" skill

#These stats only apply to ranged units
@export var rangedDamage = 20
@export var projectileSpeed = 1000
@export var projectileLife = 2
@export var rangeRadius = 500.0
@export var rateOfFire = 0.5
var canFire = true


@export var isEnemy = false
@onready var projectile = preload("res://Scenes/projectile.tscn")
@onready var corpse = preload("res://Scenes/corpse.tscn")
@export var isMelee = true
@export var isRanged = false
@export var skills = []
#SKILLS: "Skirmish", "Thrust", "Fireball"
@export var conditions = []
#CONDITIONS: "Burn", "Freeze" (They dont do anything yet)
var hp
var speed
var morale
var skirmishing = false
var shooting = false
var thrust_timer: float = 0.0

func _ready() -> void:
	$HitBox/CollisionShape2D.scale.x = meleeWeaponReach
	hp = maxHp
	morale = maxMorale
	speed = maxSpeed
	var collision_shape = $Range/CollisionShape2D
	collision_shape.shape.radius = rangeRadius
	$UnitLabel/ColorRect/Label.text = unitName
	if isMelee == false:
		$HitBox.queue_free()
	if isEnemy:
		add_to_group("Enemy")
	else:
		add_to_group("Ally")
		$UnitLabel.color = Color(0, 0, 1)
		$UnitLabel/ColorRect/HPBar.color = Color(0, 0, 1)
	
		

func get_closest_enemy() -> Node2D:
	var closest_enemy: Node2D = null
	var closest_distance = INF
	
	if isEnemy == false:
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			if enemy == self: continue
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = enemy
		return closest_enemy
	else:
		for enemy in get_tree().get_nodes_in_group("Ally"):
			if enemy == self: continue
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = enemy
		return closest_enemy

func _physics_process(delta: float) -> void:
	velocity = velocity.limit_length(speed)
	var enemy = get_closest_enemy()
	
	if enemy == null or !is_instance_valid(enemy):
		pass
	else:
		match currentState:
			State.ATTACK:
				look_at(enemy.position)
				position += (enemy.position - position).normalized() * speed * delta
				move_and_slide()
			State.RETREAT:
				look_at(enemy.position)
				rotation_degrees -= 180
				position -= (enemy.position - position).normalized() * speed * delta
				move_and_slide()
			State.SKIRMISH:
				look_at(enemy.position)
				position -= (enemy.position - position).normalized() * speed * delta
				move_and_slide()

func _process(delta: float) -> void:
	if isMelee and !skills.has("Thrust"):
		$HitBox.rotation_degrees += attackSpeed * delta
	if isMelee and skills.has("Thrust"):
		thrust_timer += delta
		var amplitude = thrustAmplitude  # Distance of movement
		var frequency = attackSpeed   # Speed of oscillation
		$HitBox.position.x = abs(sin(thrust_timer * frequency) * amplitude)
		
	if morale > maxMorale:
		morale = maxMorale
	if hp > maxHp:
		hp = maxHp
	if morale <= 0:
		morale = 0
		currentState = State.RETREAT
	elif skirmishing == false:
		currentState = State.ATTACK
	if hp <= 0:
		var corpseInstance = corpse.instantiate()
		get_tree().get_root().add_child(corpseInstance)
		corpseInstance.position = global_position
		corpseInstance.isEnemy = isEnemy
		queue_free()
	$UnitLabel/ColorRect/HPBar.scale.x = float(hp) / float(maxHp)
	$UnitLabel/ColorRect/MoraleBar.scale.x = float(morale) / float(maxMorale)
	if shooting == true and canFire == true:
		var projectileInstance = projectile.instantiate()
		get_tree().get_root().add_child(projectileInstance)
		projectileInstance.position = global_position
		projectileInstance.rotation = global_rotation
		projectileInstance.isEnemy = isEnemy
		projectileInstance.speed = projectileSpeed
		projectileInstance.life = projectileLife
		projectileInstance.damage = rangedDamage
		if skills.has("Fireball"):
			projectileInstance.skills.append("Fireball")
		canFire = false
		await get_tree().create_timer(rateOfFire).timeout
		canFire = true
	

func _on_hit_box_body_entered(body: Node2D) -> void:
	var target_group = "Ally" if isEnemy else "Enemy"
	if body.is_in_group(target_group):
		speed = 0
		body.hp -= damage
		
		await get_tree().create_timer(0.1).timeout
		speed = maxSpeed


func _on_range_area_entered(area: Area2D) -> void:
	var same_side_dead = "DeadEnemy" if isEnemy else "DeadAlly"
	var enemy_dead = "DeadAlly" if isEnemy else "DeadEnemy"
	var territory = "EnemyTerritory" if isEnemy else "Territory"

	if area.is_in_group(same_side_dead):
		morale -= randi_range(5,10)
	elif area.is_in_group(enemy_dead):
		morale += randi_range(5,10)
	if area.is_in_group(territory):
		morale += 30
	
	
		

func _on_range_body_entered(body: Node2D) -> void:
	if skills.has("Charge") and speed < maxSpeed + 100:
		var target_group = "Ally" if isEnemy else "Enemy"
		if body.is_in_group(target_group):
			speed += 100
	if isRanged:
		var target_group = "Ally" if isEnemy else "Enemy"
		if body.is_in_group(target_group):
			shooting = true
			if skills.has("Skirmish"):
				skirmishing = true
				currentState = State.SKIRMISH


func _on_range_body_exited(body: Node2D) -> void:
	if skills.has("Charge"):
		var target_group = "Ally" if isEnemy else "Enemy"
		if body.is_in_group(target_group):
			speed = maxSpeed
	if isRanged:
		var target_group = "Ally" if isEnemy else "Enemy"
		if body.is_in_group(target_group):
			shooting = false
			if skills.has("Skirmish"):
				skirmishing = false
