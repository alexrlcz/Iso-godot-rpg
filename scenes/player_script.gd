extends CharacterBody2D

@export var speed: float = 120.0

# Isometric tiles are usually 2:1, so vertical movement
# is squashed to half to match the map's perspective.
const ISO_Y_SCALE := 0.5

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Scale Y before normalizing speed so diagonals feel consistent
	var iso_dir := Vector2(input_dir.x, input_dir.y * ISO_Y_SCALE)
	velocity = iso_dir * speed

	move_and_slide()
