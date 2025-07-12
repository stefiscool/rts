extends Camera2D

@export var zoom_speed = 5.0
@export var min_zoom = 0.5
@export var max_zoom = 5.0
var move_speed = 500
var time_stopped = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("stop_time"):
		time_stopped = !time_stopped
	if time_stopped:
		Engine.time_scale = 0.0
	else:
		Engine.time_scale = 1.0
   
   # Use get_process_delta_time() for camera controls when time is stopped
	var camera_delta = 0.03
   
	if Input.is_action_just_pressed("zoom_in"):
		zoom += Vector2(zoom_speed, zoom_speed) * camera_delta
	if Input.is_action_just_pressed("zoom_out"):
		zoom -= Vector2(zoom_speed, zoom_speed) * camera_delta
		zoom.x = clamp(zoom.x, min_zoom, max_zoom)
		zoom.y = clamp(zoom.y, min_zoom, max_zoom)
   
	if Input.is_action_pressed("up"):
		position.y -= move_speed * camera_delta
	if Input.is_action_pressed("down"):
		position.y += move_speed * camera_delta
	if Input.is_action_pressed("left"):
		position.x -= move_speed * camera_delta
	if Input.is_action_pressed("right"):
		position.x += move_speed * camera_delta
	if Input.is_action_pressed("move_fast"):
		move_speed = 2000
	else:
		move_speed = 500
