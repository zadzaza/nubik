extends Node3D

@export var is_from_max: bool = false
@export var speed: float = 1.5

@onready var saw: MeshInstance3D = $Saw
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max = 7.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("default")
	var tween = create_tween().set_loops()
	if is_from_max:
		tween.tween_property(saw, "position:x", max, speed).from(-max).set_ease(Tween.EASE_OUT)
		tween.tween_property(saw, "position:x", -max, speed).from(max).set_ease(Tween.EASE_OUT)
	else:
		tween.tween_property(saw, "position:x", -max, speed).from(max).set_ease(Tween.EASE_OUT)
		tween.tween_property(saw, "position:x", max, speed).from(-max).set_ease(Tween.EASE_OUT)

func _on_saw_dead_area_body_entered(player: Player) -> void:
	get_tree().reload_current_scene()
