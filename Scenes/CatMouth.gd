extends Node2D

@export var opened = true
@export_range(0.0, 1.0) var openess_time = 0.0
@export var open_speed = 3.0
enum MonsterType {
	GREEN,
	BLUE,
	PURPLE
}

@export var monster_type : MonsterType

const OPENED_TOP_OFFSET    = 0
const OPENED_BOTTOM_OFFSET = 0
const CLOSED_TOP_OFFSET    = 0
const CLOSED_BOTTOM_OFFSET = -50

var fruit_being_eaten = null
var should_spit_fruit = false
var fruit_initial_vel = null
var cooldown = false

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
	if(cooldown):
		return
	opened = true
	fruit_being_eaten = fruit
	should_spit_fruit = false
	$EatTimer.start()

func spit_fruit_out(fruit):
	if(cooldown):
		return
	opened = true
	fruit_being_eaten = fruit
	fruit_initial_vel = fruit.linear_velocity
	fruit.hide()
	should_spit_fruit = true
	$SpitTimer.start()

func _on_eat_timer_timeout():
	if(should_spit_fruit):
		$SpitSound.play()
		play_spit_sound()
		fruit_being_eaten.linear_velocity = -fruit_initial_vel
		fruit_being_eaten.linear_velocity.y = 5
		fruit_being_eaten.position = get_parent().get_parent().position
		fruit_being_eaten.show()
		fruit_being_eaten = null
		fruit_initial_vel = null
		
	else:
		fruit_being_eaten.set_as_eated()
		fruit_being_eaten = null
		play_open_mouth_sound()
		$CrunchSound.play()

	$EatTimer.stop()
	$SpitTimer.stop()
	
	$CooldownTimer.start()
	cooldown = true
	opened = false
	should_spit_fruit = false


func _on_spit_timer_timeout():
	_on_eat_timer_timeout()


func _on_cooldown_timer_timeout():
	cooldown = false

func play_open_mouth_sound():
	match monster_type:
		MonsterType.GREEN:
			$GreenOpenMouthSound.play()
		MonsterType.PURPLE:
			$PurpleOpenMouthSound.play()
		MonsterType.BLUE:
			$BlueOpenMouthSound.play()

func play_spit_sound():
	match monster_type:
		MonsterType.GREEN:
			$GreenSpitSound.play()
		MonsterType.PURPLE:
			$PurpleSpitSound.play()
		MonsterType.BLUE:
			$BlueSpitSound.play()
