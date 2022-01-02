extends TileMap

var cat_turret = preload("res://scenes/towers/cat_turret.tscn")

var current_preview_tower = null
const TOWER_OFFSET := Vector2(16,16)
var tower_dictionary := {}
var _new_cat_turret = null ##todo
 
func _ready():
	if _new_cat_turret != null: ## todo
		_new_cat_turret.connect("disable_cat_turret(current_position)", self, "_erase_building_slots(current_position)")
	
func _process(delta):
	if current_preview_tower != null:
		var local_mouse = get_local_mouse_position()
		var tower_coord = self.world_to_map(local_mouse)
		var preview_pos = self.map_to_world( tower_coord ) + TOWER_OFFSET
		current_preview_tower.position = preview_pos
		if Input.is_mouse_button_pressed( BUTTON_LEFT ):
			if not tower_coord in tower_dictionary:
				_new_cat_turret = cat_turret.instance()
				tower_dictionary[tower_coord] = current_preview_tower
				current_preview_tower.set_preview(false)
				Globals.hayballs -= 30
			else:
				current_preview_tower.queue_free()
			current_preview_tower = null

func _erase_building_slots(current_position): ##todo
	tower_dictionary.erase(current_position)
