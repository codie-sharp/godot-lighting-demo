extends CharacterBody3D

@export var move_speed: float = 5.0
@export var mouse_sensitivity: float = 0.2
@export var spotlight_angle: float = 45.0
@export var spotlight_power: float = 5.0
@export var spotlight_color: Color = Color.WHITE
@export var ambient_light_power: float = 0.1
@export var fog_density: float = 0.02

@onready var camera = $Camera3D
@onready var lantern = $SpotLight3D
@onready var ui = $"../Control"

var mouse_captured: bool = true # Switch between game and UI

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ui.visible = false

func _input(event):
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * mouse_sensitivity * 0.01)
		camera.rotation.x = clamp(camera.rotation.x - event.relative.y * mouse_sensitivity * 0.01, -PI/2, PI/2)

	elif event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Unlock mouse
			mouse_captured = false
			ui.visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Lock mouse back
			mouse_captured = true
			ui.visible = false
			
func _process(delta):
	if not mouse_captured:
		return
		
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	velocity = direction.normalized() * move_speed
	move_and_slide()

	lantern.global_transform = camera.global_transform
