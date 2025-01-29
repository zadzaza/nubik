extends Button

@export var number: int
@export var level_to_start: PackedScene
@export var is_close: bool = false

func _ready() -> void:
	if is_close:
		set_close()

func set_free():
	self.disabled = false
	self.text = str(number)
	$TextureRect.hide()

func set_close():
	self.disabled = true
	$TextureRect.show()

func _on_pressed() -> void:
	Bridge.advertisement.show_interstitial()
	get_tree().change_scene_to_packed(level_to_start)
