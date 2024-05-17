extends RigidBody3D

const FoodType = preload("res://Scripts/Enums.gd").FoodType
@export var food_type : FoodType = FoodType.WATERMELON
var player_ref = null

func set_as_eated():
	if(player_ref):
		player_ref.fruit_eaten()
	queue_free()
