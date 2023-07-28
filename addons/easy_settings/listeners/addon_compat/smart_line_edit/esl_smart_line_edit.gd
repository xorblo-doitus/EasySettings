@tool
extends ESL


## Automatically binds itself with the SmartLineEdit given in [member smart_line_edit]


@export var smart_line_edit: SmartLineEdit:
	set(new_value):
		if new_value == null:
			if smart_line_edit != null:
				# Disconnect to clean things up, seems to work even if
				# [method Callable.unbind] was called
				smart_line_edit.value_changed.disconnect(set_value)
		else:
			new_value.value_changed.connect(
				set_value.unbind(1) # Discard `old_value`
			)
		smart_line_edit = new_value


func get_value():
	return smart_line_edit.get_value()


func update_value(new_value):
	smart_line_edit.set_valid_text_without_update(str(new_value))
