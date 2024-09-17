extends GutTest


const SETTING = "testing/fake_setting/unit_test"
const OVERRIDE = "debug"
const SETTING_AND_OVERRIDE = SETTING + "." + OVERRIDE
const SETTING_WITH_OVERRIDE = "testing/fake_setting/unit_test_with_override"


func before_each() -> void:
	ProjectSettings.set_setting(SETTING, "")
	ProjectSettings.set_setting(SETTING_AND_OVERRIDE, "")
	ProjectSettings.set_setting(SETTING_WITH_OVERRIDE, "")
	ProjectSettings.set_setting(SETTING_WITH_OVERRIDE + ".debug", "ohno")


func test_bulk() -> void:
	EasySettings.set_setting(SETTING, "start")
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING, "new")
	EasySettings.validate_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING),
		"new",
		"EasySettings.validate_bulk_setting_change() erase modifications."
	)
	
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING, "even_newer")
	EasySettings.cancel_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING),
		"new",
		"EasySettings.cancel_bulk_setting_change() does not cancel modifications."
	)


func test_bulk_set_override_full_path() -> void:
	EasySettings.set_setting(SETTING_AND_OVERRIDE, "start")
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING_AND_OVERRIDE, "new")
	EasySettings.validate_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING_AND_OVERRIDE),
		"new",
		"EasySettings.validate_bulk_setting_change() erase modifications."
	)
	
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING_AND_OVERRIDE, "even_newer")
	EasySettings.cancel_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING_AND_OVERRIDE),
		"new",
		"EasySettings.cancel_bulk_setting_change() does not cancel modifications."
	)


func test_bulk_set_override() -> void:
	EasySettings.set_setting(SETTING, "start", true, OVERRIDE)
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING, "new", true, OVERRIDE)
	EasySettings.validate_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING_AND_OVERRIDE),
		"new",
		"EasySettings.validate_bulk_setting_change() erase modifications."
	)
	
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING, "even_newer", true, OVERRIDE)
	EasySettings.cancel_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING_AND_OVERRIDE),
		"new",
		"EasySettings.cancel_bulk_setting_change() does not cancel modifications."
	)


func test_bulk_has_override() -> void:
	assert_eq(
		EasySettings.get_setting(SETTING_WITH_OVERRIDE),
		"ohno",
		"This test wasn't setup correctly"
	)
	ProjectSettings.set_setting(SETTING_WITH_OVERRIDE, "start")
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING_WITH_OVERRIDE, "new")
	EasySettings.cancel_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING_WITH_OVERRIDE),
		"ohno",
		"EasySettings.cancel_bulk_setting_change() does not cancel modifications for overrides."
	)
	
	EasySettings.set_setting(SETTING_WITH_OVERRIDE, "start")
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING_WITH_OVERRIDE, "new")
	EasySettings.validate_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING_WITH_OVERRIDE),
		"new",
		"EasySettings.validate_bulk_setting_change() erase modifications."
	)
	
	EasySettings.begin_bulk_setting_change()
	EasySettings.set_setting(SETTING_WITH_OVERRIDE, "even_newer")
	EasySettings.cancel_bulk_setting_change()
	assert_eq(
		EasySettings.get_setting(SETTING_WITH_OVERRIDE),
		"new",
		"EasySettings.cancel_bulk_setting_change() does not cancel modifications."
	)
	
