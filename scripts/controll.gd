extends Node2D
@onready var camera = $Camera2D
@onready var visible_size = get_viewport_rect().size / camera.zoom

var paralax_controll = preload("res://scenes/parralax_effect.tscn")

func _on_create_pictures_data_pictures_are_ready(picture: parralax_picture) -> void:
	if not is_node_ready():
		await ready
	var paralax = paralax_controll.instantiate()
	paralax.setup_paralax(picture, visible_size, 1.5, 10)
	add_child(paralax)
