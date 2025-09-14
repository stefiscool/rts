extends Node2D

func delete_all_nodes_in_scene(target_scene_root: Node):
	for child in target_scene_root.get_children():
		child.queue_free()
		
func _ready() -> void:
	delete_all_nodes_in_scene($".")
	get_tree().change_scene_to_file("res://Scenes/flat_battlefield.tscn")
