extends Node2D

export var _fire_delay = 5
var projectile := preload("res://scenes/towers/projectile_cat_turret.tscn")

onready var _firing_position = $firing_position
onready var _fire_timer = $fire_timer




func _on_vision_area_entered(area: Area2D) -> void:
	if _fire_timer.is_stopped():
		_fire_timer.start(_fire_delay)
		var Bullet := projectile.instance()
		Bullet.global_position = _firing_position.get_global_position()
		get_parent().add_child(Bullet)
