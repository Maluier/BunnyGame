extends Node2D

export var _health = 10
export var _fire_delay := 5.0
onready var _fire_timer = $fire_timer
export var _increase_hayballs = 0
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

func _on_hurt_box_area_entered(area: Area2D) -> void:
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
		if $shooting_sprite.frame == 3:
			Globals.hayballs += _increase_hayballs

