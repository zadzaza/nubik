extends Area3D

func _on_fall_area_body_entered(player: Player) -> void:
	Bridge.advertisement.show_interstitial()
	get_tree().reload_current_scene()
