extends Node3D

@onready var mesh_instance = $MeshInstance3D
@onready var sub_viewport = $SubViewport

@onready var amazin := $SubViewport/amazin
@onready var download := $SubViewport/download
@onready var misfire := $SubViewport/misfire
@onready var home := $SubViewport/home
@onready var virus := $SubViewport/virus
@onready var web_search := $SubViewport/web_search
@onready var homework := $SubViewport/homework

func _ready() -> void:
	SignalBus.internet_pressed.connect(_go_to_web)
	SignalBus.homework_pressed.connect(_go_to_hw)
	SignalBus.x_pressed.connect(_back_home)
	SignalBus.back_pressed.connect(_go_to_web)
	SignalBus.go_to_miss.connect(_go_to_miss)
	SignalBus.go_to_amazon.connect(_go_to_amazon)
	SignalBus.go_to_download.connect(_go_to_download)
	SignalBus.download_pressed.connect(_go_to_virus)

func _input(event):
	sub_viewport.push_input(event)
	
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
