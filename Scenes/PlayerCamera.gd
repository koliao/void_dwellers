extends Camera3D

const FoodType = preload("res://Scripts/Enums.gd").FoodType
var holded_fruit = null
const watermelon_texture = preload("res://Assets/food_1.png")
const strawberry_texture = preload("res://Assets/food_2.png")
const pineapple_texture = preload("res://Assets/food_3.png")
const throwable_food_scene = preload("res://Scenes/Entities/ThrowableFood/ThrowableFood.tscn")

const food_textures = [watermelon_texture, strawberry_texture, pineapple_texture]

func _ready():
	if(holded_fruit):
		$HoldedFruit/Sprite3D.texture = food_textures[holded_fruit]
	else:
		$HoldedFruit/Sprite3D.texture = null

func food_picked_up(food_type: FoodType):
	holded_fruit = food_type
	$HoldedFruit/Sprite3D.texture = food_textures[holded_fruit]

func throw_food():
	if(holded_fruit == null):
		return
		
	$Throw.play()
	# then check for disapearing maybe
	# TODO: set scale dynamically
	# send something like set_scale()
	var throwable_food = throwable_food_scene.instantiate()
	throwable_food.position = $HoldedFruit/Sprite3D.global_position
	throwable_food.player_ref = get_parent()
	throwable_food.set_sprite(food_textures[holded_fruit])
	throwable_food.food_type = holded_fruit

	var throw_direction = Vector3(-sin(global_rotation.y), sin(global_rotation.x), -cos(global_rotation.y))
	throwable_food.linear_velocity = throw_direction*6
	get_parent().add_sibling(throwable_food)
