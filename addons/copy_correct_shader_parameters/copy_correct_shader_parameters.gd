@tool
extends EditorPlugin

var editor_settings: EditorSettings

var dock: Control
var file_dialog: FileDialog
var load_shader_button: Button
var reload_button: Button
var copy_on_click: CheckBox
var add_quotes: CheckBox
var setting_respect_editor_settings: HBoxContainer
var respect_editor_settings: OptionButton
var shader_name: Label


var selected_file: String


func _enter_tree() -> void:
	editor_settings = EditorInterface.get_editor_settings()

	dock = preload('res://addons/copy_correct_shader_parameters/dock.tscn').instantiate()
	dock.name = 'Correct Shader Parameter'
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, dock)

	file_dialog = FileDialog.new()
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.clear_filters()
	file_dialog.add_filter('*.gdshader', 'Only .gdshader files are allowed.')
	file_dialog.file_selected.connect(_load_shader_parameters)
	file_dialog.min_size = Vector2i(900, 600)

	load_shader_button = dock.find_child('CSPLoadShaderButton') as Button
	load_shader_button.pressed.connect(_on_load_shader_button_pressed)

	reload_button = dock.find_child('CSPReloadButton') as Button
	reload_button.pressed.connect(_on_reload_button_pressed)

	copy_on_click = dock.find_child('CopyOnClickCheckButton')

	add_quotes = dock.find_child('AddQuotesCheckButton')
	add_quotes.pressed.connect(_on_add_quotes_pressed)
	setting_respect_editor_settings = dock.find_child('SettingRespectEditorSettings')
	respect_editor_settings = dock.find_child('QuoteSettingsOptionButton')

	shader_name = dock.find_child('CSPShaderName')

	dock.add_child(file_dialog)


func _exit_tree() -> void:
	file_dialog.file_selected.disconnect(_load_shader_parameters)
	file_dialog.queue_free()
	load_shader_button.pressed.disconnect(_on_load_shader_button_pressed)
	load_shader_button.queue_free()
	reload_button.pressed.disconnect(_on_reload_button_pressed)
	reload_button.queue_free()
	add_quotes.pressed.disconnect(_on_add_quotes_pressed)

	_reset_grid()
	remove_control_from_docks(dock)
	dock.queue_free()


func _load_shader_parameters(path: String):
	if path.is_empty() or path == null:
		return

	reload_button.disabled = false
	var substring: String = path.substr(path.rfind('/') + 1)
	substring = substring.substr(0, substring.length() - 9)
	shader_name.text = substring
	shader_name.get_parent().tooltip_text = substring
	_reset_grid()
	selected_file = path
	var shader = load(path)
	var grid: GridContainer = dock.find_child('GridContainer')
	var copy_button_scene: PackedScene = load('res://addons/copy_correct_shader_parameters/copy_button.tscn')
	var uniform_name_scene: PackedScene = load('res://addons/copy_correct_shader_parameters/uniform_name.tscn')
	var uniform_type_scene: PackedScene = load('res://addons/copy_correct_shader_parameters/uniform_type.tscn')
	for uniform in shader.get_shader_uniform_list():
		var uniform_name: LineEdit = uniform_name_scene.instantiate()
		uniform_name.add_to_group('csp_uniform_name')
		uniform_name.text = uniform.name
		uniform_name.select_all_on_focus = true
		uniform_name.gui_input.connect(_on_uniform_name_clicked.bind(uniform.name, uniform_name))
		grid.add_child(uniform_name)
		var uniform_type: Label = uniform_type_scene.instantiate()
		uniform_type.add_to_group('csp_uniform_type')
		uniform_type.text = type_string(uniform.type)
		grid.add_child(uniform_type)
		var copy_button: Button = copy_button_scene.instantiate()
		copy_button.add_to_group('csp_copy_button')
		(copy_button as Button).pressed.connect(_copy_uniform_name_to_clipboard.bind(uniform.name))
		grid.add_child(copy_button)


func _on_load_shader_button_pressed() -> void:
	print(editor_settings.get_setting('text_editor/completion/use_single_quotes'))
	file_dialog.popup_centered(Vector2i(900, 600))
	file_dialog.get_vbox().get_child(3).get_child(2).disabled = true


func _on_reload_button_pressed() -> void:
	_load_shader_parameters(selected_file)


func _on_uniform_name_clicked(event: InputEvent, name: String, line_edit: LineEdit) -> void:
	if not copy_on_click.button_pressed:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			line_edit.select_all()
			_copy_uniform_name_to_clipboard(name)


func _on_add_quotes_pressed() -> void:
	setting_respect_editor_settings.visible = add_quotes.button_pressed


func _copy_uniform_name_to_clipboard(name: String) -> void:
	var single_quotes: bool = respect_editor_settings.get_selected_id() == 1 or \
		respect_editor_settings.get_selected_id() == 0 and \
		editor_settings.get_setting('text_editor/completion/use_single_quotes')

	if add_quotes.button_pressed:
		name = "'%s'" % name if single_quotes else '"%s"' % name

	DisplayServer.clipboard_set(name)


func _reset_grid() -> void:
	for node in get_tree().get_nodes_in_group('csp_uniform_name'):
		node.gui_input.disconnect(_on_uniform_name_clicked)
		node.queue_free()
	for node in get_tree().get_nodes_in_group('csp_uniform_type'):
		node.queue_free()
	for node in get_tree().get_nodes_in_group('csp_copy_button'):
		(node as Button).pressed.disconnect(_copy_uniform_name_to_clipboard)
		node.queue_free()
