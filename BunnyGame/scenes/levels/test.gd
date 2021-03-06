extends "res://scenes/levels/base.gd"

var current_price = 0
signal tower_price(price)

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
		current_price = 30
		emit_signal("tower_price", current_price)
		

var trap_scene = load("res://scenes/towers/carrot_trap.tscn")
func _on_BuyCS_pressed() -> void:
	if Globals.hayballs >= 50:
		var new_tower = trap_scene.instance()
		new_tower.set_preview(true)
		turrent_grid.current_preview_tower = new_tower
		turrent_grid.add_child(new_tower)
		current_price = 50
		emit_signal("tower_price", current_price)

var shrine_scene = load("res://scenes/towers/health_shrine.tscn")
func _on_BuyHS_pressed() -> void:
	if Globals.hayballs >= 250:
		var new_tower = shrine_scene.instance()
		new_tower.set_preview(true)
		turrent_grid.current_preview_tower = new_tower
		turrent_grid.add_child(new_tower)
		current_price = 250
		emit_signal("tower_price", current_price)
		
var mg_scene = load("res://scenes/towers/machine_gun.tscn")
func _on_BuyMG_pressed() -> void:
	if Globals.hayballs >= 70:
		var new_tower = mg_scene.instance()
		new_tower.set_preview(true)
		turrent_grid.current_preview_tower = new_tower
		turrent_grid.add_child(new_tower)
		current_price = 70
		emit_signal("tower_price", current_price)
		
var haymaker_scene = load("res://scenes/towers/carrot_eaters.tscn")
func _on_BuyHM_pressed() -> void:
	if Globals.hayballs >= 500:
		var new_tower = haymaker_scene.instance()
		new_tower.set_preview(true)
		turrent_grid.current_preview_tower = new_tower
		turrent_grid.add_child(new_tower)
		current_price = 500
		emit_signal("tower_price", current_price)
		
var snake_scene = load("res://scenes/towers/snake_tower.tscn")
func _on_BuyST_pressed() -> void:
	if Globals.hayballs >= 100:
		var new_tower = snake_scene.instance()
		new_tower.set_preview(true)
		turrent_grid.current_preview_tower = new_tower
		turrent_grid.add_child(new_tower)
		current_price = 100
		emit_signal("tower_price", current_price)

func _on_SaveButton_pressed():
	SaveScript.save_gamestate()

func _on_Load_pressed():
	SaveScript.load_gamestate()

func _on_Root_disable_build_mode(trigger_bool):
	$TurrentGrid.remove_preview()


