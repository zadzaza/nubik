extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var time = 3.5
@export_range(-1, 1) var charge: int = 1

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation:y", deg_to_rad(360*charge), time)
