extends Node3D

@export var next_level_path = "res://Scenes/Levels/Forest.tscn"
var changing_level = false

func _process(delta):
	if(changing_level):
		$BackgroundSong.set_volume_db(-10.0 * $ChangeLevelTimer.get_time_left() / $ChangeLevelTimer.get_wait_time())

func activate_end_level():
	$NextLevelPortal.active = true

func change_level():
	changing_level = true
	$ChangeLevelTimer.start()

func _on_change_level_timer_timeout():
	$Player.change_level()
