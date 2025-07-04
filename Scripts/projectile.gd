extends Area2D
var damage = 100
var isEnemy
var speed = 100

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	queue_free()
	
func _on_body_entered(body):
	var target_group = "Ally" if isEnemy else "Enemy"
	if body.is_in_group(target_group):
		body.hp -= damage
		queue_free()
	
func _process(delta: float) -> void:
	var forward_direction = transform.x
	position += forward_direction * speed * delta
