extends Node3D
## The 3D character. Lives inside the player's SubViewport.
## The player script calls set_moving() and face_direction() on it.
## To use your own model: see the README.

@export var turn_speed: float = 14.0      # how fast the body rotates to face movement
@export var swing_speed: float = 10.0     # walk-cycle speed
@export var swing_angle_deg: float = 38.0 # how far arms/legs swing
@export var bob_height: float = 0.04      # small up/down bounce while walking

@onready var rig: Node3D = $Rig
@onready var left_arm: Node3D = $Rig/LeftArmPivot
@onready var right_arm: Node3D = $Rig/RightArmPivot
@onready var left_leg: Node3D = $Rig/LeftLegPivot
@onready var right_leg: Node3D = $Rig/RightLegPivot

var _moving := false
var _phase := 0.0
var _amount := 0.0  # 0 = idle pose, 1 = full walk swing


func set_moving(value: bool) -> void:
	_moving = value


## dir is a horizontal world direction (Vector3, y ignored).
func face_direction(dir: Vector3, delta: float) -> void:
	if Vector2(dir.x, dir.z).length_squared() < 0.0001:
		return
	# The character's front is its -Z axis.
	var target_yaw := atan2(-dir.x, -dir.z)
	rig.rotation.y = lerp_angle(rig.rotation.y, target_yaw, clampf(turn_speed * delta, 0.0, 1.0))


func _process(delta: float) -> void:
	_amount = move_toward(_amount, 1.0 if _moving else 0.0, delta * 8.0)
	if _moving:
		_phase += delta * swing_speed

	var swing := sin(_phase) * deg_to_rad(swing_angle_deg) * _amount
	left_leg.rotation.x = swing
	right_leg.rotation.x = -swing
	left_arm.rotation.x = -swing
	right_arm.rotation.x = swing

	rig.position.y = absf(sin(_phase)) * bob_height * _amount
