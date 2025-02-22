extends Node3D

@onready var label = $"../../CanvasLayer/SitdownLabel"
@onready var chair_camera = $ChairCamera
@onready var main_camera = $"../../Player/Camera"


var sit_down = false
var inRange = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interaction") and inRange and not sit_down:
		sit_down = true
		label.visible = false
		switch_to_chair_camera()
	elif Input.is_action_just_pressed("interaction") and sit_down:
		sit_down = false
		switch_to_main_camera()
	
func switch_to_chair_camera() -> void:
	main_camera.current = false
	chair_camera.current = true

func switch_to_main_camera() -> void:
	chair_camera.current = false
	main_camera.current = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	if "Player" in body.name:
		label.visible = true
		inRange = true 


func _on_area_3d_body_exited(body: Node3D) -> void:
	if "Player" in body.name:
		label.visible = false
		inRange = false 
