extends RigidBody2D
signal draw_force_vector(start: Vector2, end: Vector2)
signal update_fuel_percentage(percentage: float)


var _force_active := true
#var _click_start_pos := Vector2.ZERO
var _left_force_vector := Vector2.ZERO
var _right_force_vector := Vector2.ZERO
var _remaining_fuel_ratio := START_FUEL_RATIO
var _left_booster: Sprite2D = null
var _right_booster: Sprite2D = null

const MAX_FORCE_MAGNITUDE := 100.0
const START_FUEL_RATIO := 1.0
const FUEL_BURNED_PER_FORCE_SECOND := 0.0008

func _physics_process(_delta: float) -> void:
	if _force_active:
		apply_force(_left_force_vector, transform.basis_xform(_left_booster.position))
		apply_force(_right_force_vector, transform.basis_xform(_right_booster.position))
	
	
func _process(delta: float) -> void:
	var left_boost_pressed := Input.is_action_pressed("left_boost")
	var right_boost_pressed := Input.is_action_pressed("right_boost")
	
	_left_booster.visible = left_boost_pressed
	_right_booster.visible = right_boost_pressed
	
	_force_active = left_boost_pressed or right_boost_pressed
	
	_left_force_vector = Vector2.ZERO
	_right_force_vector = Vector2.ZERO
	var force_dir := transform.basis_xform(Vector2.RIGHT)
	
	if left_boost_pressed:
		_left_force_vector = MAX_FORCE_MAGNITUDE * force_dir
	if right_boost_pressed:
		_right_force_vector = MAX_FORCE_MAGNITUDE * force_dir
	
	_remaining_fuel_ratio = clampf(
		_remaining_fuel_ratio 
			- FUEL_BURNED_PER_FORCE_SECOND 
			* (_left_force_vector + _right_force_vector).length()
			* delta,
		0, 1.0)
	
	update_fuel_percentage.emit(_remaining_fuel_ratio * 100.0)
#	draw_force_vector.emit(global_position, global_position + _left_force_vector)
		
		
func _enter_tree() -> void:
	_left_booster = $LeftBooster
	_right_booster = $RightBooster
	
	_left_booster.visible = false
	_right_booster.visible = false



func _on_game_reset_player() -> void:
	_remaining_fuel_ratio =  START_FUEL_RATIO
	
