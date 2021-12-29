extends Node2D
class_name Base

export(int) var _lives := 10
export(int) var _floor_pos: int
export(int) var _air_pos: int


func _ready() -> void:
	$ScrollableCamera.limit_left = 0
	$ScrollableCamera.limit_top = 0
	$ScrollableCamera.limit_right = $Background.texture.get_width() + $CanvasLayer/UI/Towers.rect_size.x
	$ScrollableCamera.limit_bottom = $Background.texture.get_height()
	Globals.connect("score_updated", self, "_update_hayballs")
	_update_hayballs()

func _spawn_enemy(scene: PackedScene, position: String) -> void:
	var enemy := scene.instance()
	enemy.position.y = get("_%s_pos" % position)
	enemy.position.x = -32
	$Enemies.add_child(enemy)


func _on_core_area_entered(area: Area2D) -> void:
	area.queue_free()
	_lives -= 1
	$CanvasLayer/UI/Lives.text = "Lives: %d" % _lives

func _update_hayballs():
	$CanvasLayer/UI/Hayballs.text = "Hayballs: %d" % Globals.hayballs
