extends Node2D

@export var opened = true
@export_range(0.0, 1.0) var openess_time = 0.0
@export var open_speed = 4.0

const FoodType = preload("res://Scripts/Enums.gd").FoodType
@export_range(1, 3, 1) var eye_type : int = 1

const eye_1 = preload("res://Assets/eye_1.png")
const eye_2 = preload("res://Assets/eye_2.png")
const eye_3 = preload("res://Assets/eye_3.png")

const eye_textures = [eye_1, eye_2, eye_3]

const OPENED_TOP_OFFSET    = -60
const OPENED_BOTTOM_OFFSET = 140
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
	if(eye_type < eye_textures.size()):
		$EyeSprite.texture = eye_textures[eye_type] 



func toggle_opened():
	opened = not opened
	

