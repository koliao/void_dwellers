extends RigidBody3D

const FoodType = preload("res://Scripts/Enums.gd").FoodType
@export var food_type : FoodType = FoodType.WATERMELON

func set_as_eated():
	queue_free()
