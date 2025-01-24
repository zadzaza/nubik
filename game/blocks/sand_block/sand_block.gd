extends Node3D

@export var is_compilling_block: bool = false

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var body_collision: CollisionShape3D = $Sketchfab_model/root/GLTF_SceneRootNode/root_1/_0/Object_5/StaticBody3D/CollisionShape3D
@onready var area_collision: CollisionShape3D = $FallDownArea/CollisionShape3D

func _ready() -> void:
	if is_compilling_block:
		fall()

func _on_fall_down_area_body_entered(player: Player) -> void:
	fall()

func fall():
	var prev_pos = self.global_position
	anim_player.play("flashing")
	await get_tree().create_timer(1.2).timeout
	anim_player.play("RESET")
	var tween = create_tween()
	tween.tween_property(self, "position:y", global_position.y-30, 1.5).from_current()
	disable_collision()
	await tween.finished 
	self.hide()
	await get_tree().create_timer(4).timeout
	self.global_position = prev_pos
	self.show()
	enable_collision()

func disable_collision():
	body_collision.disabled = true
	area_collision.disabled = true

func enable_collision():
	body_collision.disabled = false
	area_collision.disabled = false
