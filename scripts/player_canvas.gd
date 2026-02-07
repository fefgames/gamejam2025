extends Node2D

var _force_vector_start := Vector2.ZERO
var _force_vector_end := Vector2.ZERO


func _process(_delta: float) -> void:
    queue_redraw()


func _on_player_draw_force_vector(start: Vector2, end: Vector2) -> void:
    _force_vector_start = start
    _force_vector_end = end


func _draw() -> void:
    var a: PackedVector2Array = [_force_vector_start, _force_vector_end]
    draw_multiline(a, Color.GREEN, 10.0)
