extends Camera3D

const FoodType = preload("res://Scripts/Enums.gd").FoodType
var holded_fruit : FoodType = FoodType.WATERMELON
const watermelon_texture = preload("res://Assets/food_1.png")
const strawberry_texture = preload("res://Assets/food_2.png")

const food_textures = [watermelon_texture, strawberry_texture]

func _ready():
	$HoldedFruit/Sprite3D.texture = food_textures[holded_fruit]
	pass

func _process(delta):
	pass

func food_picked_up(food_type: FoodType):
	holded_fruit = food_type
	$HoldedFruit/Sprite3D.texture = food_textures[holded_fruit]
