extends Node2D

var path:String
var depth:float
var speed:float
var view_center
var separation_power: float = 1.0
var parent_node

var focus_point: float = 5.0

@onready var red = $red
@onready var blue = $cyan

func setup_slice(picture_path: String, picture_depth:float, move_speed:float, center:Vector2) -> void:
	path = picture_path
	depth = picture_depth
	view_center = center
	speed = move_speed

func _ready() -> void:
	red.texture = load(path)
	blue.texture = load(path)
	parent_node = get_parent()
	position = view_center
	var static_direction = Vector2.RIGHT # Vagyis Vector2(1, 0)
	
	var relative_depth = (focus_point - depth) * separation_power 
	var offset_3d = static_direction * relative_depth
	red.position = -offset_3d
	blue.position = offset_3d

func _process(delta: float) -> void:
	var final_move = parent_node.shared_vector
	position = view_center + (final_move * depth * speed * 2)
