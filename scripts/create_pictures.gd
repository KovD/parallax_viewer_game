extends Node

signal pictures_are_ready(picture: parralax_picture)

func _on_load_json_ready_json(json_data: Variant) -> void:
	var picture = parralax_picture.new()
	for i in json_data["pictures"]:
		picture.parralax_list.append(Picture_slice.new(i["path"], i["depth"]))
	pictures_are_ready.emit(picture)
	
