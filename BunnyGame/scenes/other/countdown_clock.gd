extends Node2D

signal disable_build_mode(trigger_bool)

onready var clock_surface = $ClockTime
var time_diff = 0.05
var full_cycle = 30
var clock_hand_length = 32
var clock_margin = 5
var current_time = full_cycle
var is_building : bool = false

func _ready():
	var arr = [Vector2(0,0)]
	var arr2 = [Vector2(0,0)]
	var angle = 360
	for i in range(0,angle+1,1):
		arr.append( Vector2( cos(deg2rad(i))*(clock_hand_length+clock_margin), sin(deg2rad(i))*(clock_hand_length+clock_margin) ) )
		arr2.append( Vector2( cos(deg2rad(i))*(clock_hand_length), sin(deg2rad(i))*(clock_hand_length) ) )
	$ClockBack.polygon = arr
	$ClockTime.polygon = arr2
	
func _on_Timer_timeout():
	current_time -= time_diff
	var angle = 360-360*(current_time/full_cycle)
	var arr = [Vector2(0,0)]
	for i in range(0,angle+1,1):
		arr.append( Vector2( cos(deg2rad(i))*(clock_hand_length), sin(deg2rad(i))*(clock_hand_length) ) )
	$ClockTime.polygon = arr
	if current_time <= 0:
		$Timer.stop()
		if is_building:
			$ClockTime.color = Color8(0,181,229)
		else:
			$ClockTime.color = Color8(169,48,0)
		emit_signal("disable_build_mode", is_building)
		is_building = not is_building
		current_time = full_cycle
		$Timer.start()
