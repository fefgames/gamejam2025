extends RigidBody2D
signal draw_force_vector(start: Vector2, end: Vector2)

var _force_active := true
var _click_start_pos := Vector2.ZERO
var _force_vector := Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if _force_active:
		apply_central_force(_force_vector)
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pointer_select"):
		_click_start_pos = get_viewport().get_mouse_position()
	elif Input.is_action_pressed("pointer_select"):
		_force_active = true;
		
		# TODO scale force
		_force_vector = get_viewport().get_mouse_position() - _click_start_pos
	else:
		_force_active = false
		_force_vector = Vector2.ZERO
		
	draw_force_vector.emit(global_position, global_position + _force_vector)
		
