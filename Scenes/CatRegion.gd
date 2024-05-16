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

func _process(delta):
	$CatFace/CatEyeLeft.opened = opened
	$CatFace/CatEyeRight.opened = opened
	$OpenDetectionArea/CollisionShape3D.shape.radius = interaction_radius

func _on_area_3d_body_entered(body):
	if(body.is_in_group("CanOpenCatRegion")):
		opened = true

func _on_area_3d_body_exited(body):
	if(body.is_in_group("CanOpenCatRegion")):
		opened = false

func _on_food_detection_area_body_entered(fruit):
	if(fruit.is_in_group("ThrowableFood")):
		if(fruit.food_type == self._preferred_food_type()):
			$CatFace/CatMouth.eat_fruit(fruit)
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
