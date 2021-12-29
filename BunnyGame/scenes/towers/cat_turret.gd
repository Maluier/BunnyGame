extends Node2D

export var _fire_delay = 5
var projectile := preload("res://scenes/towers/projectile_cat_turret.tscn")

onready var _firing_position = $firing_position
onready var _fire_timer = $fire_timer

## Determine if the tower is for preview while placing only
var is_preview_tower := false
func set_preview(new_val: bool) -> void:
	if new_val:
		self.modulate = Color8(255,255,255,120)
	else:
		self.modulate = Color8(255,255,255,255)
	is_preview_tower = new_val

func _on_vision_area_entered(area: Area2D) -> void:
	if _fire_timer.is_stopped() and not is_preview_tower:
		_fire_timer.start(_fire_delay)
		var Bullet := projectile.instance()
		Bullet.global_position = _firing_position.get_global_position()
		get_parent().add_child(Bullet)
