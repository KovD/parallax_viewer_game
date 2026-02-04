extends Node2D

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


	


func _on_create_pictures_pictures_are_ready(picture: parralax_picture) -> void:
	label.text = String(picture.parralax_list[0].path)
