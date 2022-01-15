extends Node2D

export var _health = 10
export var _fire_delay := 5.0
onready var _fire_timer = $fire_timer
onready var _max_health = _health
## Record this tower's coordinate on the grid
var current_coord : Vector2 = Vector2.ZERO

signal disable_cat_turret(current_coord) 

## Determine if the tower is for preview while placing only
var is_preview_tower := false
func set_preview(new_val: bool) -> void:
	if new_val:
		self.modulate = Color8(255,255,255,120)
	else:
		self.modulate = Color8(255,255,255,255)
	is_preview_tower = new_val

func is_savable():
	return not is_preview_tower

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
	}
	return save_dict

var _play = false
func _on_hitbox_area_entered(area: Area2D) -> void:
	_play = true
		
func _on_hitbox_area_exited(area: Area2D) -> void:
	$hitbox.damage += 2
	if $hitbox.damage >= 25:
		$hitbox.damage = 25
	_play = false

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if is_preview_tower: return
	_health -= area.damage
	if _health <= 0:
		emit_signal("disable_cat_turret", self.current_coord) 
		queue_free()

func _process(delta: float) -> void:
	if is_preview_tower == true:
		if position.y <= 95:
			$shooting_sprite.flip_v = true
		else:
			$shooting_sprite.flip_v = false
	else:
		if _health <= _max_health:
			_health += Globals.healing
			if _health > _max_health:
				_health = _max_health
	
	if _play == true:
		$shooting_sprite.play()
	else:
		$shooting_sprite.stop()
		$shooting_sprite.frame = 3
				
