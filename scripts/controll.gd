extends Node2D
@onready var camera = $Camera2D
@onready var visible_size = get_viewport_rect().size / camera.zoom

var paralax_controll = preload("res://scenes/parralax_effect.tscn")
var threeD
var para_speed
var para_size
var heigh_path

func _on_create_pictures_data_pictures_are_ready(picture: parralax_picture) -> void:
	if not is_node_ready():
		await ready
	var paralax = paralax_controll.instantiate()
	paralax.setup_paralax(picture, heigh_path, visible_size, para_size, para_speed, threeD)
	add_child(paralax)


func _on_load_json_ready_json(json_data: Variant) -> void:
	para_speed = json_data.speed
	para_size = json_data.resize
	threeD = json_data.is_three_d
	heigh_path = json_data.heightmap
