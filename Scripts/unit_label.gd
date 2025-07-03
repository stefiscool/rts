extends ColorRect

var initial_rotation = 0.0

func _ready():
	initial_rotation = rotation
	

func _process(delta):
	rotation = initial_rotation - get_parent().rotation
