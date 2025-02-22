extends Control

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_homework_pressed() -> void:
	SignalBus.homework_pressed.emit()

func _on_internet_pressed() -> void:
	SignalBus.internet_pressed.emit()
