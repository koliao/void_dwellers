extends Node3D

@export var opened = false

func _process(delta):
	$CatEyes/CatEyeLeft.opened = opened
	$CatEyes/CatEyeRight.opened = opened

func _on_area_3d_body_entered(body):
	if(body.is_in_group("CanOpenCatRegion")):
		opened = true

func _on_area_3d_body_exited(body):
	if(body.is_in_group("CanOpenCatRegion")):
		opened = false
