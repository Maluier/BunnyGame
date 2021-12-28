extends Area2D

export(int) var _speed := 16
export(Vector2) var _direction := Vector2.RIGHT
export(int) var _health := 10



func _physics_process(delta: float) -> void:
	position += _speed * _direction * delta


func _on_TestEnemy_area_entered(area: Area2D) -> void:
	_health -= area.damage
	if _health <= 0:
		queue_free()
