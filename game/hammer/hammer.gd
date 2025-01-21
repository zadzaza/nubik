extends Node3D

@export var range_min = -100
@export var range_max = -260
@export var is_from_max: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	if is_from_max:
		play_anim(range_min, range_max)
	else:
		play_anim(range_max, range_min)

func play_anim(min, max):
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation:x", deg_to_rad(max), 1.55).from(deg_to_rad(min)).\
	set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "rotation:x", deg_to_rad(min), 1.55).from(deg_to_rad(max)).\
	set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
