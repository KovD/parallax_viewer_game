extends Node2D

var path:String
var depth:float
var speed:float
var view_center
var parent_node

@onready var pic = $Sprite2D

func setup_slice(picture_path: String, picture_depth:float, move_speed:float, center:Vector2) -> void:
	path = picture_path
	depth = picture_depth
	view_center = center
	speed = move_speed

func _ready() -> void:
	pic.texture = load(path)
	parent_node = get_parent()
	position = view_center

func _process(delta: float) -> void:
	var final_move = parent_node.shared_vector
	position = view_center + (final_move * depth * speed * 2)
