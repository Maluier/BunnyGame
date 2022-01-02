extends "res://scenes/towers/hitbox.gd"

export(int) var _speed := 16
export(Vector2) var _direction := Vector2.LEFT
onready var randomizer_cat_look = rand_range(0, 100)

func _physics_process(delta: float) -> void:
	position += _speed * _direction * delta


func _on_projectile_cat_turret_area_entered(area: Area2D) -> void:
	queue_free()


func _on_Timer_timeout() -> void:
	$Sprite.visible = true
	if randomizer_cat_look >= 66:
		$Sprite.play("var1")
	elif randomizer_cat_look <= 33:
		$Sprite.play("var2")
	else:
		$Sprite.play("var3")
