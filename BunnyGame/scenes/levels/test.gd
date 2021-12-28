extends Base


func _ready() -> void:
	var t := Timer.new()
	t.wait_time = 1.0
	add_child(t)
	t.connect("timeout", self, "_spawn_enemy", [load("res://scenes/enemies/test_enemy.tscn"), "floor"])
	t.start()
