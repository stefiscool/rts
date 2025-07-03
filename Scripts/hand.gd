extends Area2D

var canPlace = false
@onready var unit = preload("res://Scenes/Units/infantry.tscn")


#func _input(event):
	#if event is InputEventMouseMotion:
		#position = event.position

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("click") and canPlace:
		var unitInstance = unit.instantiate()
		unitInstance.position = get_global_mouse_position()
		get_tree().get_root().add_child(unitInstance)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Territory":
		canPlace = true

func _on_area_exited(area: Area2D) -> void:
	if area.name == "Territory":
		canPlace = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ally") or body.is_in_group("Enemy"):
		canPlace = false

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Ally") or body.is_in_group("Enemy"):
		canPlace = true
