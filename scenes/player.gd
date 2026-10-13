
extends CharacterBody2D

@export var move_speed: float = 160.0

func _physics_process(_delta: float) -> void:
	var input_dir := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
        "move_down"
	)

	# Convert grid directions into isometric screen directions.
	var iso_dir := Vector2(
		input_dir.x - input_dir.y,
		(input_dir.x + input_dir.y) * 0.5
	)

	velocity = iso_dir.normalized() * move_speed
	move_and_slide()
