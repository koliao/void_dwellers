extends Node3D
@export var fill_row_1 : bool = true
@export var fill_row_2 : bool = true
@export var fill_row_3 : bool = true
@export var fill_row_4 : bool = true
@export var fill_row_5 : bool = true
@export var fill_row_6 : bool = true
@export var fill_row_7 : bool = true

func _ready():
	if(fill_row_1): 
		$row_1.generate_row()
	if(fill_row_2): 
		$row_2.generate_row()
	if(fill_row_3): 
		$row_3.generate_row()
	if(fill_row_4): 
		$row_4.generate_row()
	if(fill_row_5): 
		$row_5.generate_row()
	if(fill_row_6): 
		$row_6.generate_row()
	if(fill_row_7): 
		$row_7.generate_row()
	pass
