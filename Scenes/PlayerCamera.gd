extends Camera3D

const FoodType = preload("res://Scripts/Enums.gd").FoodType
var holded_fruit : FoodType = FoodType.WATERMELON
const watermelon_texture = preload("res://Assets/food_1.png")
const strawberry_texture = preload("res://Assets/food_2.png")
const throwable_food_scene = preload("res://Scenes/Entities/ThrowableFood/ThrowableFood.tscn")

const food_textures = [watermelon_texture, strawberry_texture]

func _ready():
	$HoldedFruit/Sprite3D.texture = food_textures[holded_fruit]
	pass

func _process(delta):
	pass

func food_picked_up(food_type: FoodType):
	holded_fruit = food_type
	$HoldedFruit/Sprite3D.texture = food_textures[holded_fruit]

func throw_food():
	# Instantiate a throwing food in player?
	# add velocity
	# then check for disapearing maybe
	# TODO: set scale dynamically
	# send something like set_scale()
	var throwable_food = throwable_food_scene.instantiate()
	throwable_food.global_position = $HoldedFruit/Sprite3D.global_position
	print(global_rotation, rotation)
	# y == 0  | x -> 0/1
	# y == PI | x -> 0/-1
	#var throw_direction = rotation.normalized()
	var throw_direction = Vector3(-sin(global_rotation.y), sin(global_rotation.x), -cos(global_rotation.y))
	print("THROW: ", throw_direction)
	#print(throw_direction)
	throwable_food.linear_velocity = throw_direction*4
	get_parent().add_sibling(throwable_food)
