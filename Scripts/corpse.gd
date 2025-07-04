extends Area2D

var isEnemy

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	if isEnemy:
		add_to_group("DeadEnemy")
	else:
		add_to_group("DeadAlly")
	await get_tree().create_timer(10).timeout
	queue_free()
