extends Control

@onready var pause_manager: PauseManager = $PauseManager
@onready var scope: Panel = $Scope
@onready var pause: HBoxContainer = $Pause
@onready var restart: HBoxContainer = $Restart

var is_restart: bool = false

func _ready():
	Bridge.advertisement.interstitial_state_changed.connect(_on_interstitial_state_changed)
	await get_tree().process_frame
	show_pause()

func show_pause(is_restart: bool = false):
	self.is_restart = is_restart
	pause_manager._pause()

func _on_pause_manager_pause() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	scope.hide()
	if not is_restart:
		pause.show()
	else:
		pause_manager.action_names.clear()
		restart.show()
		
func _on_pause_manager_resume() -> void:
	if not is_restart:
		scope.show()
		pause.hide()

func _on_exit_btn_pressed() -> void:
	pause_manager._resume()
	get_tree().change_scene_to_file("res://game/main_menu/main_menu.tscn")

func _on_continue_btn_pressed() -> void:
	pause_manager._resume()

func _on_restart_btn_pressed() -> void:
	Bridge.advertisement.show_interstitial()
	#get_tree().reload_current_scene()

func _on_interstitial_state_changed(state):
	if state == "closed" or state == "failed":
		pause_manager._resume()
		get_tree().reload_current_scene()
