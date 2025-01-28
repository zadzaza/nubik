extends Control

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var to_levels: Button = $ToLevels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Bridge.storage.set(["level", "is_tutorial_completed", "coins"], ["dungeon_123", true, 42], Callable(self, "_on_storage_set_completed"))
	Bridge.platform.send_message(Bridge.PlatformMessage.GAME_READY)
	Bridge.advertisement.set_minimum_delay_between_interstitial(30)
	for b in h_box_container.get_children():
		b.set_free()
		
func _on_storage_set_completed(success):
	print("On Storage Set Completed, success: ", success)

func _on_to_levels_pressed() -> void:
	to_levels.hide()
	h_box_container.show()
