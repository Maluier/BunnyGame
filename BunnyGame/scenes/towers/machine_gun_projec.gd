extends "res://scenes/towers/hitbox.gd"

export(int) var _speed := 16
export(Vector2) var _direction := Vector2.LEFT
onready var randomizer_cat_look = rand_range(0, 100)

func _physics_process(delta: float) -> void:
	position += _speed * _direction * delta


func _on_projectile_cat_turret_area_entered(area: Area2D) -> void:
	queue_free()
