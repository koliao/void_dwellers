extends Node3D
const FoodType = preload("res://Scripts/Enums.gd").FoodType
@export var food_type : FoodType = FoodType.WATERMELON

const watermelon_texture = preload("res://Assets/food_1.png")
const strawberry_texture = preload("res://Assets/food_2.png")
const pineapple_texture = preload("res://Assets/food_3.png")

const food_textures = [watermelon_texture, strawberry_texture, pineapple_texture]

func _ready():
	pass

func _process(delta):
	if(food_type < food_textures.size()):
		$MeshInstance3D/FoodIcon.texture = food_textures[food_type] 


func _on_area_3d_body_entered(body):
	if(body.is_in_group("Player")):
		body.pick_up_food(food_type)
