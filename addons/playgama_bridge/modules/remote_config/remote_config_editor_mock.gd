var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return false


func get(options = null, callback = null):
	if callback == null:
		return
	
	callback.call(false, null)
