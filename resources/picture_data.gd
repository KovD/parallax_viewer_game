extends Resource
class_name Picture_slice

var path:String = ""
var depth:int = 0 

func _init(p_path: String = "", p_depth: int = 0):
	path = p_path
	depth = p_depth
