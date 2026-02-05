extends Node2D

var path: String
var height_path: String # ÚJ: Itt tároljuk el a heightmap útvonalát
var depth: float
var speed: float
var view_center: Vector2
var separation_power: float = 0.3
var parent_node

var focus_point: float = 5.0

@onready var sprite = $Sprite

func setup_slice(picture_path: String, height: String, picture_depth: float, move_speed: float, center: Vector2) -> void:
	path = picture_path
	height_path = height
	depth = picture_depth
	view_center = center
	speed = move_speed

func _ready() -> void:
	sprite.texture = load(path)
	parent_node = get_parent()
	position = view_center
	
	if height_path != "":
		var depth_tex = load(height_path)
		sprite.material.set_shader_parameter("depth_map", depth_tex)
		var main_offset = (depth-focus_point) * separation_power * 0.01
		
		sprite.material.set_shader_parameter("layer_offset", main_offset)
		sprite.material.set_shader_parameter("depth_strength", 0.015 * separation_power)


func _process(delta: float) -> void:
	# 1. A Réteg mozgása (Ez maradt a régi)
	var final_move = parent_node.shared_vector
	position = view_center + (final_move * depth * speed * 2)
	
	# 2. --- ÚJ RÉSZ: Beküldjük a mozgást a Shadernek is ---
	if height_path != "":
		# A final_move az egér iránya. Beküldjük, hogy a shader "rángassa" a pixeleket.
		# A negatív előjel (-) függhet attól, merre akarod, hogy dőljön a domborzat.
		sprite.material.set_shader_parameter("motion_offset", -final_move * 0.5)
