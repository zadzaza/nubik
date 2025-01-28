extends Node

func change_scene(level_to_start: PackedScene):
	var level = level_to_start.instantiate()
	level.name = "Level"
	get_tree().change_scene_to_file("res://game/main/main.tscn")
	get_tree().root.call_deferred("add_child", level)
	
		
