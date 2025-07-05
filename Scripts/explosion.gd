extends Area2D
var isEnemy = true
var damage = 10
var explosionSpeed = 10
var explosionTime = 0.3
var skills = []

func _ready() -> void:
	await get_tree().create_timer(explosionTime).timeout
	queue_free()
	
func _on_body_entered(body):
	var target_group = "Ally" if isEnemy else "Enemy"
	if body.is_in_group(target_group):
		body.hp -= damage
		if skills.has("Fireball"):
			body.conditions.append("Burn")
			print(str(body.conditions))
	
	
func _process(delta: float) -> void:
	scale += Vector2(explosionSpeed,explosionSpeed) * delta
