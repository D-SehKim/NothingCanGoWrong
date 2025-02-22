extends Control

@onready var text := $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	SignalBus.x_pressed.emit()

func _on_search_pressed() -> void:
	if text.text == "www.download.com/greatestgame":
		SignalBus.go_to_download.emit()
	elif text.text == "www.amazin.com/greatestgame":
		SignalBus.go_to_amazon.emit()
	else:
		SignalBus.go_to_miss.emit()


func _on_line_edit_text_submitted(_new_text: String) -> void:
	if text.text == "www.download.com/greatestgame":
		SignalBus.go_to_download.emit()
	elif text.text == "www.amazin.com/greatestgame":
		SignalBus.go_to_amazon.emit()
	else:
		SignalBus.go_to_miss.emit()


func _on_line_edit_focus_entered() -> void:
	var event = InputEventKey.new()
	event.set_keycode(KEY_E)
	InputMap.action_erase_event("interaction", event)


func _on_line_edit_focus_exited() -> void:
	var event = InputEventKey.new()
	event.set_keycode(KEY_E)
	InputMap.action_add_event("interaction", event)
