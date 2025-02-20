extends CharacterBody3D

@export var move_speed: float = 5
@export var mouse_sensitivity: float = 0.2
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera = $Camera3D
@onready var lantern = $SpotLight3D
@onready var ui = $"../Control"

var mouse_captured: bool = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ui.visible = false

func _input(event):
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * mouse_sensitivity * 0.01)
		camera.rotation.x = clamp(camera.rotation.x - event.relative.y * mouse_sensitivity * 0.01, -PI/2, PI/2)

	elif event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse_captured = false
			ui.visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			mouse_captured = true
			ui.visible = false

func _physics_process(delta):
	if not mouse_captured:
		return

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x

	# Move along the ground while keeping vertical velocity
	if direction != Vector3.ZERO:
		direction = direction.normalized() * move_speed
		velocity.x = direction.x
		velocity.z = direction.z
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

	lantern.global_transform = camera.global_transform
