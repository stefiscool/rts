extends Camera2D

@export var zoom_speed = 1.0
@export var min_zoom = 0.5
@export var max_zoom = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("zoom_in"):
		zoom += Vector2(zoom_speed, zoom_speed) * delta
	if Input.is_action_just_pressed("zoom_out"):
		zoom -= Vector2(zoom_speed, zoom_speed) * delta

	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)
	
	var move_speed = 300  
	if Input.is_action_pressed("up"):
		position.y -= move_speed * delta
	if Input.is_action_pressed("down"):
		position.y += move_speed * delta
	if Input.is_action_pressed("left"):
		position.x -= move_speed * delta
	if Input.is_action_pressed("right"):
		position.x += move_speed * delta
