extends Control

@export var total : int = 16
@export var current : int = 0

var is_hidden : bool = true
var sliding_time = 0.3
const HIDE_TIME : float = 0.4
const HIDDEN_POSITION : float = -50
const SHOW_POSITION : float = 0

var label : String = String.num_int64(current) + " / " + String.num_int64(total)

func _process(delta):
	label = String.num_int64(current) + " / " + String.num_int64(total)
	$Label.text = label
	if(is_hidden):
		position.y = HIDDEN_POSITION
	else:
		var t = 1.0 - clamp(sliding_time / HIDE_TIME, 0.0, 1.0)
		position.y = lerp(HIDDEN_POSITION, SHOW_POSITION, t)
		
		sliding_time -= delta
		sliding_time = max(0, sliding_time)

func slide_in():
	is_hidden = false
	sliding_time = HIDE_TIME
