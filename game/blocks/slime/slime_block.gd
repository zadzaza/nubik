extends Node3D


func _on_slime_jump_area_body_entered(player: Player) -> void:
	player.jump_height *= 1.4
	player.jumping = true
