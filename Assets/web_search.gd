extends Control

@onready var text := $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/control_screen.tscn")

func _on_search_pressed() -> void:
	if text.text == "www.download.com/greatestgame":
		get_tree().change_scene_to_file("res://Assets/download.tscn")
	elif text.text == "www.amazin.com/greatestgame":
		get_tree().change_scene_to_file("res://Assets/amazin.tscn")
	else:
		get_tree().change_scene_to_file("res://Assets/misfire.tscn")


func _on_line_edit_text_submitted(_new_text: String) -> void:
	if text.text == "www.download.com/greatestgame":
		get_tree().change_scene_to_file("res://Assets/download.tscn")
	elif text.text == "www.amazin.com/greatestgame":
		get_tree().change_scene_to_file("res://Assets/amazin.tscn")
	else:
		get_tree().change_scene_to_file("res://Assets/misfire.tscn")
