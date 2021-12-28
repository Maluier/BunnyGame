extends Camera2D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("click"):
		position -= event.relative
		position.x = clamp(position.x, get_viewport().size.x/2, limit_right-get_viewport().size.x/2)
		position.y = clamp(position.y, get_viewport().size.y/2, limit_bottom-get_viewport().size.y/2)
