extends Node

signal score_updated

var hayballs = 100 setget _set_hayballs

func _ready():
	pass

func _set_hayballs(value):
	hayballs = value
	emit_signal("score_updated")

func save() -> Dictionary:
	var save_dict = {
		"name":name,
		"hayballs": hayballs,
	}
	return save_dict

func load(new_info: Dictionary) -> void:
	self.hayballs = new_info["hayballs"]
