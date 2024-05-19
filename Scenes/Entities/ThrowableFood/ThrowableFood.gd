extends RigidBody3D

const FoodType = preload("res://Scripts/Enums.gd").FoodType
@export var food_type : FoodType = FoodType.WATERMELON
var player_ref = null
var despawning = false
	
func _process(delta):
	if(despawning):
		$Sprite3D.transparency = 1.0 - $DespawnTimer.get_time_left() / $DespawnTimer.get_wait_time()

func set_as_eated():
	if(player_ref):
		player_ref.fruit_eaten()
	queue_free()

func set_sprite(texture):
	$Sprite3D.texture = texture

func _on_wait_to_despawn_timer_timeout():
	despawning = true
	$DespawnTimer.start()


func _on_despawn_timer_timeout():
	queue_free()
