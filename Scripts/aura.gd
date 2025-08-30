extends Area2D
var isEnemy = true
var skills = []

func _on_body_entered(body: Node2D) -> void:
	var target_group = "Ally" if isEnemy else "Enemy"
	var allied_group = "Enemy" if isEnemy else "Ally"
	if body.is_in_group(allied_group):
		if skills.has("Morale Aura"):
			body.morale += 30
		if skills.has("Heal Aura"):
			body.hp += 30
	if body.is_in_group(target_group):
		if skills.has("Fear Aura"):
			body.morale -= 70
