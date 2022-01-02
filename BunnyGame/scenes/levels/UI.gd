extends Control


var _is_build_time = true

func _process(delta: float) -> void:
	if _is_build_time == false:
		self.visible = false
	elif _is_build_time == true:
		self.visible = true


func _on_Root_disable_build_mode(trigger_bool) -> void:
	_is_build_time = trigger_bool
