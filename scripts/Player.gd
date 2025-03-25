extends CharacterBody3D

@export var speed: float = 10.0
@export var sprint_multiplier: float = 1.3
@export var crouch_multiplier: float = 0.6
@export var acceleration: float = 5.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3
@export var in_control: bool = true

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var animation: AnimationPlayer = $AnimationPlayer

var camera_x_rotation: float = 0.0
var is_crouching = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	if in_control:
		var movement_vector = Vector3.ZERO

		if Input.is_action_pressed("movement_forward"):
			movement_vector -= head.basis.z
		if Input.is_action_pressed("movement_backward"):
			movement_vector += head.basis.z
		if Input.is_action_pressed("movement_left"):
			movement_vector -= head.basis.x
		if Input.is_action_pressed("movement_right"):
			movement_vector += head.basis.x

		movement_vector = movement_vector.normalized()

		if Input.is_action_just_pressed("crouch"):
			is_crouching = !is_crouching
			animation.play("Crouch Down" if is_crouching else "Crouch Up")

		var current_speed = speed
		if is_crouching:
			current_speed *= crouch_multiplier
		elif Input.is_action_pressed("sprint"):
			current_speed *= sprint_multiplier

		velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
		velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)

		# Apply gravity
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Jumping
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_power

		move_and_slide()


func _disable_movement():
	in_control = false
	velocity = Vector3(0, 0, 0)


func kill():
	_disable_movement()
