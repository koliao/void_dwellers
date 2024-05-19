extends Node3D

@export var active = false

func _process(delta):
	if(active):
		$Inner.show()
	else:
		$Inner.hide()

func _on_area_3d_body_entered(body):
	if(body.is_in_group("Player") and active):
		body.start_change_level()
