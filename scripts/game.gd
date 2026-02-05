extends Node

signal reset_player_state()

const Player = preload("res://scripts/player.gd")
const Puzzle = preload("res://scripts/puzzle.gd")

@export var player: Player = null
@export var puzzle: Puzzle = null

var _do_physics_reset := false

func _process(delta: float) -> void:
	if _do_physics_reset:
#		player.freeze = true
#		player.global_position = puzzle.player_spawn.global_position

		PhysicsServer2D.body_set_state(
			player.get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, puzzle.player_spawn.transform
		)
		player.linear_velocity = Vector2.ZERO
		player.angular_velocity = 0.0
		player.reset_physics_interpolation()
		_do_physics_reset = false
	else:
		pass
#		player.freeze = false

func _on_reset_button_pressed() -> void:
	_do_physics_reset = true
	reset_player_state.emit()
	
