extends RigidBody2D
signal draw_force_vector(start: Vector2, end: Vector2)
signal update_fuel_percentage(percentage: float)


var _force_active := true
var _click_start_pos := Vector2.ZERO
var _force_vector := Vector2.ZERO
var _remaining_fuel_ratio := START_FUEL_RATIO

const MAX_FORCE_MAGNITUDE := 300.0
const START_FUEL_RATIO := 1.0
const FUEL_BURNED_PER_FORCE_SECOND := 0.0008

func _physics_process(_delta: float) -> void:
	if _force_active:
		apply_central_force(_force_vector)
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pointer_select"):
		_click_start_pos = get_viewport().get_mouse_position()
	elif Input.is_action_pressed("pointer_select") and _remaining_fuel_ratio > 0.0:
		_force_active = true;
		
		# TODO scale force
		var mouse_drag_vector := get_viewport().get_mouse_position() - _click_start_pos
		_force_vector = mouse_drag_vector.normalized() * clampf(mouse_drag_vector.length(), 0.0, MAX_FORCE_MAGNITUDE)
	else:
		_force_active = false
		_force_vector = Vector2.ZERO
	
	_remaining_fuel_ratio = clampf(_remaining_fuel_ratio - FUEL_BURNED_PER_FORCE_SECOND * _force_vector.length() * delta, 0, 1.0)
	
	update_fuel_percentage.emit(_remaining_fuel_ratio * 100.0)
	draw_force_vector.emit(global_position, global_position + _force_vector)
		


func _on_game_reset_player() -> void:
	_remaining_fuel_ratio =  START_FUEL_RATIO
	
