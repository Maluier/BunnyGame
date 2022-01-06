extends Node2D

export(int) var _lives := 10
export(int) var _floor_pos: int
export(int) var _air_pos: int


func _ready() -> void:
	Globals.connect("score_updated", self, "_update_hayballs")
	_update_hayballs()

func _spawn_enemy(scene: PackedScene, position: String) -> void:
	var enemy := scene.instance()
	enemy.position.y = get("_%s_pos" % position)
	enemy.position.x = -32
	$Enemies.add_child(enemy)


func _on_core_area_entered(area: Area2D) -> void:
	_lives -= area.damage
	$CanvasLayer/HUD/Lives.text = "Lives: %d" % _lives
	if _lives <= 0:
		pass ## go to game over screen

func _update_hayballs():
	$CanvasLayer/HUD/Hayballs.text = "Hayballs: %d" % Globals.hayballs
