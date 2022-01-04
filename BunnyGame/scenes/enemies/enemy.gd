extends Area2D

export(int) var _speed := 16
export(Vector2) var _direction := Vector2.RIGHT
export(int) var _health := 10
export(int) var _hayball_increment := 20
export(int) var damage := 2


func _physics_process(delta: float) -> void:
	position += _speed * _direction * delta


func _on_TestEnemy_area_entered(area: Area2D) -> void:
	_health -= area.damage
	if _health <= 0:
		Globals.hayballs += _hayball_increment
		queue_free()
