extends Button

@export var number: int
@export var level_to_start: PackedScene
@export var is_close: bool = false

var is_pressed = false

func _ready() -> void:
	if is_close:
		set_close()
		
	Bridge.advertisement.interstitial_state_changed.connect(_on_interstitial_state_changed)

func set_free():
	self.disabled = false
	self.text = str(number)
	$TextureRect.hide()

func set_close():
	self.disabled = true
	$TextureRect.show()

func _on_pressed() -> void:
	is_pressed = true
	Bridge.advertisement.show_interstitial()

func _on_interstitial_state_changed(state):
	if state == "failed" or state == "closed":
		if is_pressed:
			get_tree().call_deferred("change_scene_to_packed", level_to_start)
		
	
