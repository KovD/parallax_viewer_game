extends Node

@export var path = ""
signal ready_json

func _ready() -> void:
	load_json(path)

func load_json(path:String):
	if not FileAccess.file_exists(path):
		printerr("Hiba: A fájl nem található: ", path)
		return null
		
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	ready_json.emit()
	return JSON.parse_string(content)
	
