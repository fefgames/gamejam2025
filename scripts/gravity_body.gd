extends Node2D

const DENSITY := 1.0

## acceleration due to gravity at the given position 
func gravity_at(pos: Vector2) -> Vector2:
    var radius := (pos - global_position).length()
	assert(radius >= scale.x)
	var mass := PI * scale.x * scale.x * DENSITY 
	return mass * 10.0 / (radius * radius)
	
