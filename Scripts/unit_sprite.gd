extends Sprite2D

func _ready() -> void:
	while true:
		if frame == 11:
			frame = 0
		frame += 1
		await get_tree().create_timer(0.08).timeout
	
	
