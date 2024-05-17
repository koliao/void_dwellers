extends Node3D

@export var opened = false
@export var interaction_radius = 4.0

enum MonsterType {
	GREEN,
	BLUE,
	PURPLE
}

const FoodType = preload("res://Scripts/Enums.gd").FoodType
@export var monster_type : MonsterType

var already_eaten = false
var body_observed = null

func _process(delta):
	$CatFace/CatEyeLeft.opened = opened or already_eaten
	$CatFace/CatEyeRight.opened = opened or already_eaten
	$OpenDetectionArea/CollisionShape3D.shape.radius = interaction_radius
	if(not opened and body_observed != null and body_observed.is_holding_fruit()):
		opened = true

func _on_area_3d_body_entered(body):
	if(body.is_in_group("CanOpenCatRegion")):
		if(body.is_holding_fruit()):
			opened = true
		else:
			body_observed = body

func _on_area_3d_body_exited(body):
	if(body.is_in_group("CanOpenCatRegion")):
		opened = false
		body_observed = null

func _on_food_detection_area_body_entered(fruit):
	if(fruit.is_in_group("ThrowableFood")):
		if(not already_eaten):
			if(fruit.food_type == self._preferred_food_type()):
				$CatFace/CatMouth.eat_fruit(fruit)
				already_eaten = true
			else:
				$CatFace/CatMouth.spit_fruit_out(fruit)

func _preferred_food_type():
	match monster_type:
		MonsterType.GREEN:
			return FoodType.WATERMELON
		MonsterType.PURPLE:
			return FoodType.STRAWBERRY
		MonsterType.BLUE:
			return FoodType.STRAWBERRY
