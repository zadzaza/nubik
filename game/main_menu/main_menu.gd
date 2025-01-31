extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var to_levels: Button = $ToLevels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SaveManager.levels_complete = SaveManager.load_game()
	Bridge.platform.send_message(Bridge.PlatformMessage.GAME_READY)
	Bridge.advertisement.set_minimum_delay_between_interstitial(30)
	for b in h_box_container.get_children():
		if SaveManager.levels_complete.has(b.name):
			if SaveManager.levels_complete[b.name] == true:
				b.set_free()
			else:
				b.set_close()
		else:
			b.set_close()
	
func _on_to_levels_pressed() -> void:
	to_levels.hide()
	h_box_container.show()
