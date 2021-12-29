extends Node

signal score_updated

var hayballs = 100 setget _set_hayballs

func _set_hayballs(value):
	hayballs = value
	emit_signal("score_updated")
