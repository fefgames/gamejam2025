extends MeshInstance2D

func _process(delta: float) -> void:
    var parent := get_parent() as Node2D
    
    rotation = -1 * parent.rotation