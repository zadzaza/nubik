extends Node3D


func _on_finish_area_body_entered(player: Player) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Bridge.advertisement.show_interstitial()
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn")
	#get_tree().reload_current_scene()
