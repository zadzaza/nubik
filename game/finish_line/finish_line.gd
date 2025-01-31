extends Node3D

@export var next_complete_level: int

func _on_finish_area_body_entered(player: Player) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SaveManager.levels_complete["level"+str(next_complete_level)] = true
	SaveManager.save_game(SaveManager.levels_complete)
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn")

func _on_storage_get_completed(success, data):
	if success:
		if data != null:
			print(data)
		else:
			# No data for the key 'level'
			print("Data is null")
