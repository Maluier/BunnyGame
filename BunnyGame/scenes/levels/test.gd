extends Base


func _ready() -> void:
	var t := Timer.new()
	t.wait_time = 1.0
	add_child(t)
	t.connect("timeout", self, "_spawn_enemy", [load("res://scenes/enemies/test_enemy.tscn"), "floor"])
	t.start()
	
## Dealing with placing tower
onready var turrent_grid = $TurrentGrid
var tower_scene = load("res://scenes/towers/cat_turret.tscn")
func _on_Tower_purchased():
	var new_tower = tower_scene.instance()
	new_tower.set_preview(true)
	turrent_grid.current_preview_tower = new_tower
	turrent_grid.add_child(new_tower)
