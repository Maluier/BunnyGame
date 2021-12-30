extends Control


var _is_toggled = false

func _process(delta: float) -> void:
	if _is_toggled == false and Input.is_action_just_released("ui_toggle"):
		_is_toggled = true
		self.visible = false
	elif _is_toggled == true and Input.is_action_just_released("ui_toggle"):
		_is_toggled = false
		self.visible = true
