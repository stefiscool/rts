extends CharacterBody2D

enum State {ATTACK, RETREAT}
var currentState = State.ATTACK
@export var cost = 10
@export var maxHp = 100
@export var maxMorale = 50
@export var unitName = "Infantry"
@export var damage = 10
@export var maxSpeed = 200
@export var attackSpeed = 6000
@export var meleeWeaponReach = 1.0

@export var rangedDamage = 20
@export var projectileSpeed = 1000
@export var rangeRadius = 500.0
@export var rateOfFire = 0.5
var canFire = true

@export var isEnemy = false
@onready var projectile = preload("res://Scenes/projectile.tscn")
@onready var corpse = preload("res://Scenes/corpse.tscn")
@export var isMelee = true
@export var isRanged = false
@export var skills = []
@export var conditions = []

var hp
var speed
var morale
var skirmishing = false

func _ready() -> void:
	$HitBox/CollisionShape2D.scale.x = meleeWeaponReach
	hp = maxHp
	morale = maxMorale
	speed = maxSpeed
	var collision_shape = $Range/CollisionShape2D
	collision_shape.shape.radius = rangeRadius
	$UnitLabel/ColorRect/Label.text = unitName
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
				position -= (enemy.position - position).normalized() * speed * delta
				move_and_slide()

func _process(delta: float) -> void:
	$HitBox.rotation_degrees += attackSpeed * delta
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


func _on_hit_box_body_entered(body: Node2D) -> void:
	var target_group = "Ally" if isEnemy else "Enemy"
	if body.is_in_group(target_group):
		speed = 0
		body.hp -= damage
		
		await get_tree().create_timer(0.1).timeout
		speed = maxSpeed


func _on_range_area_entered(area: Area2D) -> void:
	# Define groups based on allegiance
	var same_side_dead = "DeadEnemy" if isEnemy else "DeadAlly"
	var enemy_dead = "DeadAlly" if isEnemy else "DeadEnemy"
	var territory = "EnemyTerritory" if isEnemy else "Territory"

	# Check if unit enters an area that affects morale
	if area.is_in_group(same_side_dead):
		morale -= randi_range(5,10)
	elif area.is_in_group(enemy_dead):
		morale += randi_range(5,10)
	if area.is_in_group(territory):
		morale += 30
	
	
		

func _on_range_body_entered(body: Node2D) -> void:
	if isRanged:
		var target_group = "Ally" if isEnemy else "Enemy"
		if body.is_in_group(target_group) and canFire == true:
			var projectileInstance = projectile.instantiate()
			get_tree().get_root().add_child(projectileInstance)
			projectileInstance.position = global_position
			projectileInstance.rotation = global_rotation
			projectileInstance.isEnemy = isEnemy
			projectileInstance.speed = projectileSpeed
			projectileInstance.damage = rangedDamage
			if skills.has("Fireball"):
				projectileInstance.skills.append("Fireball")
			canFire = false
			skirmishing = true
			currentState = State.RETREAT
			await get_tree().create_timer(rateOfFire).timeout
			currentState = State.ATTACK
			canFire = true
			skirmishing = false
