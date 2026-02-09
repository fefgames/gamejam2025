extends Label


func _on_player_speed_updated(speed: float) -> void:
    text = String.num(speed, 1)
