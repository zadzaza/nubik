extends Area3D

func _on_fall_area_body_entered(player: Player) -> void:
	player.show_restart()
