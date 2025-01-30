extends Control

@onready var pause_manager: PauseManager = $PauseManager
@onready var scope: Panel = $Scope
@onready var pause: HBoxContainer = $Pause


func _on_pause_manager_pause() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	scope.hide()
	pause.show()

func _on_pause_manager_resume() -> void:
	scope.show()
	pause.hide()

func _on_exit_btn_pressed() -> void:
	pause_manager._resume()
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn")

func _on_continue_btn_pressed() -> void:
	pause_manager._resume()
