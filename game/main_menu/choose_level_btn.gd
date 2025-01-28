extends Button

@export var number: int
@export var level_to_start: PackedScene

func set_free():
	self.disabled = false
	self.text = str(number)

func set_close():
	self.disabled = true
	self.text = str("🔒")

func _on_pressed() -> void:
	Bridge.advertisement.show_interstitial()
	get_tree().change_scene_to_packed(level_to_start)
