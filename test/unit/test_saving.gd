extends GutTest


const setting = "testing/fake_setting/unit_test"


func before_each() -> void:
	EasySettings.set_setting(setting, "")


func test_bulk() -> void:
	EasySettings.set_setting(setting, "start")
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(setting, "new")
	EasySettings.validate_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(setting),
		"new",
		"EasySettings.validate_bulk_setting_change() erase modifications."
	)
	
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(setting, "even_newer")
	EasySettings.cancel_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(setting),
		"new",
		"EasySettings.cancel_bulk_setting_change() does not cancel modifications."
	)
	
