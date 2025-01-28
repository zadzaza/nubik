var is_supported : get = _is_supported_getter
var is_get_list_supported : get = _is_get_list_supported_getter
var is_native_popup_supported : get = _is_native_popup_supported_getter

func _is_supported_getter():
	return _js_achievements.isSupported

func _is_get_list_supported_getter():
	return _js_achievements.isGetListSupported

func _is_native_popup_supported_getter():
	return _js_achievements.isNativePopupSupported
	
var _js_achievements = null
var _unlock_callback = null
var _js_unlock_then = JavaScriptBridge.create_callback(self._on_js_unlock_then)
var _js_unlock_catch = JavaScriptBridge.create_callback(self._on_js_unlock_catch)
var _get_list_callback = null
var _js_get_list_then = JavaScriptBridge.create_callback(self._on_js_get_list_then)
var _js_get_list_catch = JavaScriptBridge.create_callback(self._on_js_get_list_catch)
var _show_native_popup_callback = null
var _js_show_native_popup_then = JavaScriptBridge.create_callback(self._on_js_show_native_popup_then)
var _js_show_native_popup_catch = JavaScriptBridge.create_callback(self._on_js_show_native_popup_catch)
var _utils = load("res://addons/playgama_bridge/utils.gd").new()


func unlock(options = null, callback = null):
	if _unlock_callback != null:
		return
	
	_unlock_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_achievements.unlock(js_options).then(_js_unlock_then).catch(_js_unlock_catch)

func get_list(options = null, callback = null):
	if _get_list_callback != null:
		return

	_get_list_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_achievements.getList(js_options).then(_js_get_list_then).catch(_js_get_list_catch)

func show_native_popup(options = null, callback = null):
	if _show_native_popup_callback != null:
		return

	_show_native_popup_callback = callback
	
	var js_options = null
	if options:
		js_options = _utils.convert_to_js(options)
	
	_js_achievements.showNativePopup(js_options).then(_js_show_native_popup_then).catch(_js_show_native_popup_catch)


func _init(js_achievements):
	_js_achievements = js_achievements

func _on_js_unlock_then(args):
	if _unlock_callback != null:
		_unlock_callback.call(true)
		_unlock_callback = null

func _on_js_unlock_catch(args):
	if _unlock_callback != null:
		_unlock_callback.call(false)
		_unlock_callback = null

func _on_js_get_list_then(args):
	if _get_list_callback != null:
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_OBJECT:
				var array = []
				for i in range(data.length):
					var js_item = data[i]
					var js_item_keys = JavaScriptBridge.get_interface("Object").keys(js_item)
					var item = {}
					for j in range(js_item_keys.length):
						var key = js_item_keys[j]
						item[key] = js_item[key]
					array.append(item)
				_get_list_callback.call(true, array)
			_:
				_get_list_callback.call(false, [])
		_get_list_callback = null

func _on_js_get_list_catch(args):
	if _get_list_callback != null:
		_get_list_callback.call(false, [])
		_get_list_callback = null

func _on_js_show_native_popup_then(args):
	if _show_native_popup_callback != null:
		_show_native_popup_callback.call(true)
		_show_native_popup_callback = null

func _on_js_show_native_popup_catch(args):
	if _show_native_popup_callback != null:
		_show_native_popup_callback.call(false)
		_show_native_popup_callback = null
