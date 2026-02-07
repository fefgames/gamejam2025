extends Node2D

const DENSITY := 1.0
const GRAVITY_SCALE := 10.0

## Acceleration due to gravity from this object at the given position
func gravity_at(pos: Vector2) -> Vector2:
    var radius := (pos - global_position).length()
    var dir := (global_position - pos).normalized()
    assert(radius >= scale.x)
    var mass := PI * scale.x * scale.x * DENSITY
    return mass * GRAVITY_SCALE / (radius * radius) * dir
