extends Node2D

@export var opened = true
@export_range(0.0, 1.0) var openess_time = 0.0
@export var open_speed = 3.0

const OPENED_TOP_OFFSET    = -60
const OPENED_BOTTOM_OFFSET = 86
const CLOSED_TOP_OFFSET    = 30
const CLOSED_BOTTOM_OFFSET = 60

func _ready():
	if(opened):
		$EyelidMaskTop.offset.y = -60
		$EyelidMaskBottom.offset.y = 86
	else:
		$EyelidMaskTop.offset.y = -30
		$EyelidMaskBottom.offset.y = 60

func _process(delta):
	var open_direction_sign = 1 if opened else -1
	var open_factor = open_speed * delta * open_direction_sign
	openess_time = clamp(openess_time + open_factor, 0.0, 1.0)
	$EyelidMaskTop.offset.y = lerp(CLOSED_TOP_OFFSET, OPENED_TOP_OFFSET, openess_time)
	$EyelidMaskBottom.offset.y = lerp(CLOSED_BOTTOM_OFFSET, OPENED_BOTTOM_OFFSET, openess_time)

func toggle_opened():
	opened = not opened
	

