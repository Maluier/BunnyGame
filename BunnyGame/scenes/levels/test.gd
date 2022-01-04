extends "res://scenes/levels/base.gd"


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
	if Globals.hayballs >= 30:
		var new_tower = tower_scene.instance()
		new_tower.set_preview(true)
		turrent_grid.current_preview_tower = new_tower
		turrent_grid.add_child(new_tower)

var trap_scene = load("res://scenes/towers/carrot_trap.tscn")
func _on_BuyCS_pressed() -> void:
	if Globals.hayballs >= 50:
		var new_tower = trap_scene.instance()
		new_tower.set_preview(true)
		turrent_grid.current_preview_tower = new_tower
		turrent_grid.add_child(new_tower)

func _on_SaveButton_pressed():
	SaveScript.save_gamestate()

func _on_Load_pressed():
	SaveScript.load_gamestate()



