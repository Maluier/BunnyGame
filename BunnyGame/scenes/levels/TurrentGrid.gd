extends TileMap
var current_preview_tower = null
const TOWER_OFFSET := Vector2(16,16)
var tower_dictionary := {}
var _current_price = 0

func _ready():	
	get_parent().connect("tower_price", self, "_set_price")
	
func _process(_delta):
	if current_preview_tower != null:
		var local_mouse = get_local_mouse_position()
		var tower_coord = self.world_to_map(local_mouse)
		var preview_pos = self.map_to_world( tower_coord ) + TOWER_OFFSET
		current_preview_tower.position = preview_pos
		if Input.is_mouse_button_pressed( BUTTON_LEFT ):
			if not tower_coord in tower_dictionary and (tower_coord[1] == 4 or tower_coord[1] == 1):
				tower_dictionary[tower_coord] = current_preview_tower
				current_preview_tower.set_preview(false)
				current_preview_tower.connect("disable_cat_turret", self, "_erase_building_slots")
				current_preview_tower.current_coord = tower_coord
				Globals.hayballs -= _current_price
			else:
				current_preview_tower.queue_free()
			current_preview_tower = null

func remove_preview():
	if current_preview_tower != null:
		current_preview_tower.queue_free()
		current_preview_tower = null

func _erase_building_slots(current_position): 
	tower_dictionary.erase(current_position)

func _set_price(price):
	_current_price = price
