extends Node3D

@export var opened = false
@export var interaction_radius = 2.0

func _process(delta):
	$CatFace/CatEyeLeft.opened = opened
	$CatFace/CatEyeRight.opened = opened
	$OpenDetectionArea/CollisionShape3D.shape.radius = interaction_radius * 1/scale.x

func _on_area_3d_body_entered(body):
	if(body.is_in_group("CanOpenCatRegion")):
		opened = true

func _on_area_3d_body_exited(body):
	if(body.is_in_group("CanOpenCatRegion")):
		opened = false

func _on_food_detection_area_body_entered(body):
	if(body.is_in_group("ThrowableFood")):
		$CatFace/CatMouth.eat_fruit(body)
