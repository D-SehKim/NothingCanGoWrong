extends Node3D

@onready var amazin := $SubViewport/amazin
@onready var download := $SubViewport/download
@onready var misfire := $SubViewport/misfire
@onready var home := $SubViewport/home
@onready var virus := $SubViewport/virus
@onready var web_search := $SubViewport/web_search
@onready var homework := $SubViewport/homework

@onready var display = $MeshInstance3D
@onready var viewport = $SubViewport
@onready var area = $Area3D

var mesh_size = Vector2()

var mouse_entered = false
var mouse_held = false
var mouse_inside = false

var last_mouse_pos_3D = null
var last_mouse_pos_2D = null
var sitting_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	area.mouse_entered.connect(func(): mouse_entered = true)
	viewport.set_process_input(true)
	SignalBus.internet_pressed.connect(_go_to_web)
	SignalBus.homework_pressed.connect(_go_to_hw)
	SignalBus.x_pressed.connect(_back_home)
	SignalBus.back_pressed.connect(_go_to_web)
	SignalBus.go_to_miss.connect(_go_to_miss)
	SignalBus.go_to_amazon.connect(_go_to_amazon)
	SignalBus.go_to_download.connect(_go_to_download)
	SignalBus.download_pressed.connect(_go_to_virus)
	SignalBus.sitting_down.connect(_sit_down)
	
	
func _sit_down():
	sitting_down = !sitting_down

func _unhandled_input(event):
	if sitting_down:
		var is_mouse_event = false
		if event is InputEventMouseMotion or event is InputEventMouseButton:
			is_mouse_event = true
			
		if mouse_entered and (is_mouse_event or mouse_held):
			handle_mouse(event)
		elif not is_mouse_event:
			viewport.push_input(event,true)
	
	
func handle_mouse(event):
	mesh_size = display.mesh.size
	
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		mouse_held = event.pressed
	
	var mouse_pos3D = find_mouse(event.global_position)
	
	mouse_inside = mouse_pos3D != null
	
	if mouse_inside:
		mouse_pos3D = area.global_transform.affine_inverse() * mouse_pos3D
		last_mouse_pos_3D = mouse_pos3D
	else:
		mouse_pos3D = last_mouse_pos_3D
		if mouse_pos3D == null:
			mouse_pos3D = Vector3.ZERO
	var mouse_pos2D = Vector2(mouse_pos3D.x, -mouse_pos3D.y)
	
	#convert from -meshsize/2 to meshsize/2
	mouse_pos2D.x += mesh_size.x / 2
	mouse_pos2D.y += mesh_size.y / 2
	#convert to 0 to 1
	mouse_pos2D.x = mouse_pos2D.x / mesh_size.x
	mouse_pos2D.y = mouse_pos2D.y / mesh_size.y
	#convert to viewport range 0 to veiwport size
	mouse_pos2D.x = mouse_pos2D.x * viewport.size.x
	mouse_pos2D.y = mouse_pos2D.y * viewport.size.y
	
	event.position = mouse_pos2D
	event.global_position = mouse_pos2D
	
	if event is InputEventMouseMotion:
		if last_mouse_pos_2D == null:
			event.relative = Vector2(0,0)
		else:
			event.relative = mouse_pos2D - last_mouse_pos_2D
		
	last_mouse_pos_2D = mouse_pos2D
	
	viewport.push_input(event)
	

func find_mouse(pos:Vector2):
	var camera = get_viewport().get_camera_3d()
	
	var dss:PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var rayparam = PhysicsRayQueryParameters3D.new()
	rayparam.from = camera.project_ray_origin(pos)
	var dis = 5
	rayparam.to = rayparam.from + camera.project_ray_normal(pos) * dis
	rayparam.collide_with_bodies = false
	rayparam.collide_with_areas = true
	
	var result = dss.intersect_ray(rayparam)
	if result.size() > 0:
		return result.position
	else:
		return null

func _go_to_hw():
	home.visible = false
	homework.visible = true
			
func _go_to_web():
	home.visible = false
	web_search.visible = true
	
func _back_home():
	home.visible = true
	web_search.visible = false
	amazin.visible = false
	misfire.visible = false
	homework.visible = false
	
func _go_to_miss():
	misfire.visible = true
	web_search.visible = false
	
func _go_to_amazon():
	amazin.visible = true
	web_search.visible = false
	
func _go_to_download():
	download.visible = true
	web_search.visible = false
	
func _go_to_virus():
	virus.visible = true
	download.visible = false
