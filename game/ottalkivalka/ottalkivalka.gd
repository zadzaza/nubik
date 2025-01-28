extends Node3D

@export var is_from_max: bool = true

@onready var node: Node3D = $Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_anim()

func play_anim():
	var tween = create_tween().set_loops()
	tween.tween_property(node, "position:x", -6, 0.5).from(0).\
	set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUINT)
	tween.tween_property(node, "position:x", 0, 1.5).from(-6).\
	set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
# TRANS_ELASTIC
# TRANS_BACK
