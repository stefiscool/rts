extends Area2D
var damage = 100
var isEnemy
var speed = 100
var life = 2.0
var skills = []
@onready var explosion = preload("res://Scenes/explosion.tscn")


func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	if skills.has("Fireball"):
		$Polygon2D.color = Color(0,0,0)
	if skills.has("Stone"):
		scale.x += 10
		scale.y += 10
		$CollisionShape2D.scale = Vector2(1,1)
		$Polygon2D.color = Color(50,50,50)
	if skills.has("Flashbang") and randi_range(1,3) == 3:
		var explosionInstance = explosion.instantiate()
		get_tree().get_root().add_child(explosionInstance)
		explosionInstance.position = global_position
		explosionInstance.isEnemy = isEnemy
		explosionInstance.damage = 30
		explosionInstance.explosionSpeed = 50
		explosionInstance.explosionTime = 0.15
		explosionInstance.skills = ["Flashbang"]
	await get_tree().create_timer(life).timeout
	queue_free()
	
	
func _on_body_entered(body):
	var target_group = "Ally" if isEnemy else "Enemy"
	if body.is_in_group(target_group):
		body.hp -= damage
		if skills.has("Fireball"):
			var explosionInstance = explosion.instantiate()
			get_tree().get_root().add_child(explosionInstance)
			explosionInstance.position = global_position
			explosionInstance.isEnemy = isEnemy
			explosionInstance.damage = 100
			explosionInstance.explosionSpeed = 10
			explosionInstance.explosionTime = 0.3
			explosionInstance.skills = ["Fireball"]
		if !skills.has("Stone"):
			queue_free()
		
	
func _process(delta: float) -> void:
	var forward_direction = transform.x
	position += forward_direction * speed * delta
