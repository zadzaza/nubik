extends VisibleOnScreenNotifier3D

@export var meshes: Array[MeshInstance3D]

func _on_screen_entered() -> void:
	for m in meshes:
		if m:
			m.visible = true

func _on_screen_exited() -> void:
	for m in meshes:
		if m:
			m.visible = false
