extends Area2D
var damage = 100
var isEnemy
var speed = 100
var skills = []
@onready var explosion = preload("res://Scenes/explosion.tscn")

func _ready() -> void:
	await get_tree().create_timer(2).timeout
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
		queue_free()
		
	
func _process(delta: float) -> void:
	var forward_direction = transform.x
	position += forward_direction * speed * delta
