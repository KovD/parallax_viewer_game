extends Node

@export var p_path = ""
signal ready_json(json_data)

func _ready() -> void:
	load_json(p_path)

func load_json(path:String):
	if not FileAccess.file_exists(path):
		printerr("Hiba: A fájl nem található: ", path)
		return null
		
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	ready_json.emit(JSON.parse_string(content))
	return
	
