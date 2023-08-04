@tool
extends Node


@export var setting: String = "testing/fake_setting/smart_line_edit":
	set(new):
		setting = new
		var descendants: Array[Node] = get_children()
		while descendants:
			var descendant: Node = descendants.pop_back()
			descendants.append_array(descendant.get_children())
			if descendant is ESL:
				descendant.setting = setting
