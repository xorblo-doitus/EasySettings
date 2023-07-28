extends Object
class_name EasySettings


static var all_listeners: Dictionary = {}


## Does [method ProjectSettings.set_setting] then update listeners bound to this setting.
static func set_setting(setting: String, value) -> void:
	ProjectSettings.set_setting(setting, value)
	ProjectSettings.save_custom("override.cfg")
	
	var listeners: Array[ESL] = all_listeners.get(setting, _get_empty_ESL_array())
	for listener in listeners:
		if is_instance_valid(listener):
			listener._update_value(value)
		else:
			# Defered because would modify the Array during iteration otherwise.
			unbind_listener.call_deferred(setting, listener)


## Bind a listener so he will be updated when setting's value is changed.
static func bind_listener(setting: String, listener: ESL) -> void:
	var listeners: Array[ESL] = all_listeners.get(setting, _get_empty_ESL_array())
	if listeners.is_empty():
		all_listeners[setting] = listeners
	
	listeners.append(listener)


## Unbind listener : he will no longer be updated when it's linked setting is changed.
## [br]Will raise an error if listener is not bound.
static func unbind_listener(setting: String, listener: ESL) -> void:
	var listeners: Array[ESL] = all_listeners.get(setting)
	listeners.erase(listener)
	
	if listeners.is_empty():
		all_listeners.erase(setting)


static func _get_empty_ESL_array() -> Array[ESL]:
	return []
