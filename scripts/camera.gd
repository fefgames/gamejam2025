extends RigidBody2D

const SPRING_CONSTANT := 1000.0
const DAMPING_CONSTANT := 40.0
#const ROT_SPRING_CONSTANT := 2000.0
#const ROT_DAMPING_CONSTANT := 400.0

var _force_vector := Vector2.ZERO
#var _torque := 0.0
var _target_rotation := 0.0

func _physics_process(delta: float) -> void:
	apply_central_force(_force_vector)
#	apply_torque(_torque)
	global_rotation = _target_rotation

func _on_player_position_updated(player_global_pos: Vector2) -> void:
	var spring_force := SPRING_CONSTANT * (player_global_pos - global_position)
	var damping_force := -1.0 * DAMPING_CONSTANT * linear_velocity
	_force_vector = spring_force + damping_force
	

func _on_player_rotation_updated(player_global_rot: float) -> void:
#	pass
#	global_rotation = player_global_rot
	_target_rotation = player_global_rot
#	var player_rot := player_global_rot
#	var rot_diff := player_rot - global_rotation
#
#	assert(player_rot <  PI)
#	assert(global_rotation < PI)
#	assert(player_rot >= -PI)
#	assert(global_rotation >= -PI)
#	if rot_diff > PI:
#		rot_diff = 2 * PI - rot_diff	
#	elif rot_diff < -PI:
#		rot_diff = -2 * PI - rot_diff	
#	
#	
#	var spring_torque := ROT_SPRING_CONSTANT * rot_diff
#	var damping_torque := -1.0 * ROT_DAMPING_CONSTANT * angular_velocity
#	_torque = spring_torque + damping_torque
