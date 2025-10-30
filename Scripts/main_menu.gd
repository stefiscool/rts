extends Node2D



func delete_nodes_in_group(group_name: String):
	var nodes_to_delete = get_tree().get_nodes_in_group(group_name)
	for node in nodes_to_delete:
		node.queue_free()
		
func _on_quick_battle_pressed() -> void:
	delete_nodes_in_group("Enemy")
	delete_nodes_in_group("Ally")
	Global.heroPlaced = false
	Global.enemyHeroPlaced = false
	get_tree().change_scene_to_file("res://Scenes/unit_select.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
