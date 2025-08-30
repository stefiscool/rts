extends Area2D
var isEnemy = true
var damage = 10
var explosionSpeed = 15
var explosionTime = 1
var skills = []

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	if skills.has("Flashbang"):
		add_to_group("Flashbang")
		$Polygon2D.color = Color(255,255,0)
	await get_tree().create_timer(explosionTime).timeout
	queue_free()
	
func _on_body_entered(body):
	var target_group = "Ally" if isEnemy else "Enemy"
	if body.is_in_group(target_group):
		body.hp -= damage
		if skills.has("Flashbang"):
			body.conditions.append("Stun")
			
	
	
func _process(delta: float) -> void:
	scale += Vector2(explosionSpeed,explosionSpeed) * delta
