extends Node2D

@export var opened = true
@export_range(0.0, 1.0) var openess_time = 0.0
@export var open_speed = 3.0

const OPENED_TOP_OFFSET    = 0
const OPENED_BOTTOM_OFFSET = 0
const CLOSED_TOP_OFFSET    = 0
const CLOSED_BOTTOM_OFFSET = -50

var fruit_being_eaten = null
var should_spit_fruit = false

func _ready():
	pass

func _process(delta):
	var open_direction_sign = 1 if opened else -1
	var open_factor = open_speed * delta * open_direction_sign
	openess_time = clamp(openess_time + open_factor, 0.0, 1.0)
	$MouthMaskTop.offset.y = lerp(CLOSED_TOP_OFFSET, OPENED_TOP_OFFSET, openess_time)
	$MouthMaskBottom.offset.y = lerp(CLOSED_BOTTOM_OFFSET, OPENED_BOTTOM_OFFSET, openess_time)
	$MouthMaskBottom.offset.y = lerp(CLOSED_BOTTOM_OFFSET, OPENED_BOTTOM_OFFSET, openess_time)
	$ColorRect.scale.y = openess_time

func toggle_opened():
	opened = not opened
	
func eat_fruit(fruit):
	opened = true
	fruit_being_eaten = fruit
	should_spit_fruit = false
	$EatTimer.start()

func spit_fruit_out(fruit):
	opened = true
	fruit_being_eaten = fruit
	should_spit_fruit = true
	$EatTimer.start()

func _on_eat_timer_timeout():
	if(should_spit_fruit):
		$SpitSound.play()
		$DisgustSound.play()
		fruit_being_eaten.linear_velocity *= -1
		fruit_being_eaten.position = get_parent().get_parent().position

	else:
		fruit_being_eaten.set_as_eated()
		fruit_being_eaten = null
		$OpenMouthSound.play()
		$CrunchSound.play()

	$EatTimer.stop()
	opened = false
	should_spit_fruit = false
