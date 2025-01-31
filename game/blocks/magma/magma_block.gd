extends Node3D


func _on_magma_area_body_entered(player: Player) -> void:
	player.burn()
