extends Node2D



func _on_quick_battle_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/flat_battlefield.tscn")
