class_name Player extends CharacterBody3D

@export_category("Player")
@export_range(1, 35, 0.1) var speed: float = 10.0 # m/s
@export_range(10, 400, 0.1) var acceleration: float = 100 # m/s^2

@export_range(0.1, 3.0, 0.1) var jump_height: float = 4 # m
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1

var jumping: bool = false
var mouse_captured: bool = false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_dir: Vector2 # Input direction for movement
var look_dir: Vector2 # Input direction for look/aim

var walk_vel: Vector3 # Walking velocity 
var grav_vel: Vector3 # Gravity velocity 
var jump_vel: Vector3 # Jumping velocity
var current_speed : float = speed

var monsters_fed : int = 0
var current_fed_target = 3

@onready var camera: Camera3D = $Camera

func _ready() -> void:
	capture_mouse()
	$Ui/FeedCounter.current = monsters_fed
	$Ui/FeedCounter.total = current_fed_target
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_camera()
	if Input.is_action_just_pressed("jump"): jumping = true
	if Input.is_action_pressed("run"):
		current_speed = speed * 1.5
	else:
		current_speed = speed
	if Input.is_action_just_pressed("exit"): get_tree().quit()
	if(Input.is_action_just_pressed("throw")):
		throw_food()
	if(Input.is_action_just_pressed("slide_test")):
		$Ui/FeedCounter.slide_in()
	
func _physics_process(delta: float) -> void:
	if mouse_captured: _handle_joypad_camera_rotation(delta)
	velocity = _walk(delta) + _gravity(delta) + _jump(delta)
	move_and_slide()

func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_camera(sens_mod: float = 1.0) -> void:
	camera.rotation.y -= look_dir.x * camera_sens * sens_mod
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)

func _handle_joypad_camera_rotation(delta: float, sens_mod: float = 1.0) -> void:
	var joypad_dir: Vector2 = Input.get_vector("look_left","look_right","look_up","look_down")
	if joypad_dir.length() > 0:
		look_dir += joypad_dir * delta
		_rotate_camera(sens_mod)
		look_dir = Vector2.ZERO

func _walk(delta: float) -> Vector3:
	move_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var _forward: Vector3 = camera.global_transform.basis * Vector3(move_dir.x, 0, move_dir.y)
	var walk_dir: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	walk_vel = walk_vel.move_toward(walk_dir * current_speed * move_dir.length(), acceleration * delta)
	return walk_vel

func _gravity(delta: float) -> Vector3:
	grav_vel = Vector3.ZERO if is_on_floor() else grav_vel.move_toward(Vector3(0, velocity.y - gravity, 0), gravity * delta)
	return grav_vel

func _jump(delta: float) -> Vector3:
	if jumping:
		if is_on_floor(): jump_vel = Vector3(0, sqrt(4 * jump_height * gravity), 0)
		jumping = false
		return jump_vel
	jump_vel = Vector3.ZERO if is_on_floor() else jump_vel.move_toward(Vector3.ZERO, gravity * delta)
	return jump_vel

func pick_up_food(food_type):
	$Camera.food_picked_up(food_type)
	
func throw_food():
	$Camera.throw_food()

func fruit_eaten():
	if(monsters_fed == 0):
		$Ui/FeedCounter.slide_in()
		
	monsters_fed += 1
	$Ui/FeedCounter.current = monsters_fed
	
	if(monsters_fed >= current_fed_target):
		change_level()

func is_holding_fruit():
	return $Camera.holded_fruit != null

func change_level():
	get_tree().change_scene_to_file("res://Scenes/Levels/Forest.tscn")
