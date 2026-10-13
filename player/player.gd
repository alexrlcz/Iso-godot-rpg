extends CharacterBody2D
## 2D physics + movement, 3D visuals.
## The 3D character is rendered by a SubViewport and shown through a Sprite2D.

@export var speed: float = 120.0

# Tiles are 2:1, so vertical screen movement is squashed to half.
const ISO_Y_SCALE := 0.5

@onready var viewport: SubViewport = $SubViewport
@onready var sprite: Sprite2D = $Sprite2D
@onready var character = $SubViewport/Character3D


func _ready() -> void:
	# Show what the 3D camera sees as a normal 2D sprite.
	sprite.texture = viewport.get_texture()


func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = Vector2(input_dir.x, input_dir.y * ISO_Y_SCALE) * speed
	move_and_slide()

	var moving := input_dir != Vector2.ZERO
	character.set_moving(moving)
	if moving:
		character.face_direction(_screen_to_world(input_dir), delta)


## Converts a screen-space direction (right/down) into a 3D ground direction,
## matching the 45-degree yaw of the Camera3D in player.tscn.
func _screen_to_world(v: Vector2) -> Vector3:
	return Vector3(v.x + v.y, 0.0, v.y - v.x).normalized()
