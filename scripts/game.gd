extends Node

signal reset_player_state
signal apply_gravity_body(body: GravityBody)

const GravityBody := preload("res://scripts/gravity_body.gd")
const Player := preload("res://scripts/player.gd")
const Puzzle := preload("res://scripts/puzzle.gd")

@export var player: Player = null
@export var puzzle_scenes: Array[PackedScene] = []

var _current_puzzle: Puzzle = null
var _do_physics_reset := true

func _process(delta: float) -> void:
    if _do_physics_reset:

        PhysicsServer2D.body_set_state(
            player.get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, _current_puzzle.player_spawn.transform
        )
        player.linear_velocity = Vector2.ZERO
        player.angular_velocity = 0.0
        player.reset_physics_interpolation()
        _do_physics_reset = false
    else:
        pass

func _on_reset_button_pressed() -> void:
    _do_physics_reset = true
    reset_player_state.emit()

func _ready() -> void:
    pass
    var instance := puzzle_scenes[0].instantiate()
    add_child(instance)
    _current_puzzle = get_child(get_child_count() - 1)
