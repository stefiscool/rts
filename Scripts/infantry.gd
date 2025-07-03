extends CharacterBody2D

@export var maxHp = 100
@export var unitName = "Infantry"
@export var damage = 10
@export var maxSpeed = 200
@export var attackSpeed = 6000
@export var rangeRadius = 100
@export var isEnemy = false
var hp
var speed

func _ready() -> void:
	hp = maxHp
	speed = maxSpeed
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
	var enemy = get_closest_enemy()
	
	if enemy == null or !is_instance_valid(enemy):
		pass
	else:
		look_at(enemy.position)
		position += (enemy.position - position).normalized() * speed * delta
		move_and_slide()

func _process(delta: float) -> void:
	$HitBox.rotation_degrees += attackSpeed * delta
	if hp <= 0:
		queue_free()
	$UnitLabel/ColorRect/HPBar.scale.x = float(hp) / float(maxHp)


func _on_hit_box_body_entered(body: Node2D) -> void:
	var target_group = "Ally" if isEnemy else "Enemy"
	if body.is_in_group(target_group):
		speed = 0
		body.hp -= damage
		
		await get_tree().create_timer(0.1).timeout
		speed = maxSpeed
