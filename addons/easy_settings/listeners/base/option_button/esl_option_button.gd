extends ESL
class_name ESLOptionButton

## Automatically binds itself with the [OptionButton] given in [member option_button].


## The OptionButton to wich this Listener is bound. Modifying this variable
## automatically connects/disconnects new/previous OptionButton.
@export var option_button: OptionButton:
	set(new_value):
		if option_button != null:
			_disconnect(option_button)
		if new_value != null:
			_connect(new_value)
		option_button = new_value
		if start_synced and is_node_ready():
			force_update()


func get_value() -> int:
	if option_button == null:
		return false
	return option_button.selected


func update_value(new_value: int, old_value, forced: bool = false) -> void:
	if (
			sync == Sync.ALWAYS
			or (_is_no_value(old_value) or option_button.selected == old_value)
			or forced
		) and option_button != null:
		option_button.selected = new_value


func _connect(to_connect: OptionButton) -> void:
	to_connect.item_selected.connect(set_value)


func _disconnect(to_disconnect: OptionButton) -> void:
	if to_disconnect.item_selected.is_connected(set_value): # Just in case
		to_disconnect.item_selected.disconnect(set_value)
