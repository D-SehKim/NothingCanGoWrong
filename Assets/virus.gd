extends Control
@onready var text := $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_line_edit_text_submitted(new_text: String) -> void:
	if text.text == "01/01/1977":
		SignalBus.x_pressed.emit()
		#play correct audio
	else:
		pass #play "wrong" audio
