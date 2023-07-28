@static_unload
extends Node
class_name ESL

## Base class for EasySetting's Listeners
## 
## Implements virtual methods

## Default value of [method set_value] parameter meaning the method
## will get the value with [method get_value], allowing passing null
## as an argument.
static var _no_value: RefCounted = RefCounted.new()

## The full path of the setting this EasySetting's Listener will be bind.
## [br]To find the path of a setting, find it in [code]Project → Project's Settings → General[/code]
## then click on it to see it's path under the search bar. You can right click
## the setting too then [code]copy property path[/code] or press [code]ctrl + shift + C[/code]
@export_placeholder("application/config/name") var setting: String = "":
	set(new_setting):
		if setting != "":
			EasySettings.unbind_listener(setting, self)
		if new_setting != "":
			EasySettings.bind_listener(new_setting, self)
		setting = new_setting


## [b][Virtual][/b] Method called to get the value. It should return the right type of value.
func get_value():
	pass


## [b][Virtual][/b] Method called when the setting is modified by another source.
func update_value(new_value) -> void:
	pass


## Method to call when value is changed. If connected to a signal with more
## than 1 value emitted, remember to discard them.
## [br]If no [param new_value] is passed, it uses [method get_value] to find it.
func set_value(new_value = _no_value) -> void:
	_ignore_update = true
	EasySettings.set_setting(setting, get_value() if _is_no_value(new_value) else new_value)
	_ignore_update = false


## Workaround for `==` raising an error instead of returning false when
## Comparing two things that it don't know how to compare
func _is_no_value(to_test) -> bool:
	return typeof(to_test) == TYPE_OBJECT and to_test == _no_value


var _ignore_update: bool = false
func _update_value(new_value) -> void:
	if _ignore_update: return
	update_value(new_value)
