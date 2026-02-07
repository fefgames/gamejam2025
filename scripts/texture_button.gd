extends TextureButton


func _ready() -> void:
    modulate = Color.GRAY


func _on_mouse_entered() -> void:
    modulate = Color.WHITE


func _on_mouse_exited() -> void:
    modulate = Color.GRAY
