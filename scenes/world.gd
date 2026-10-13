
extends Node2D

const TILE_WIDTH := 64.0
const TILE_HEIGHT := 32.0
const GRID_SIZE := 20

func _draw() -> void:
	var half_width := TILE_WIDTH / 2.0
	var half_height := TILE_HEIGHT / 2.0
	var center := Vector2(640, 360)

	for x in range(GRID_SIZE):
		for y in range(GRID_SIZE):
			var grid_x := x - GRID_SIZE / 2
			var grid_y := y - GRID_SIZE / 2

			var pos := center + Vector2(
				(grid_x - grid_y) * half_width,
				(grid_x + grid_y) * half_height
			)

			var points := PackedVector2Array([
				pos + Vector2(0, -half_height),
				pos + Vector2(half_width, 0),
				pos + Vector2(0, half_height),
				pos + Vector2(-half_width, 0),
				pos + Vector2(0, -half_height)
			])

			draw_polyline(points, Color(0.35, 0.38, 0.42), 1.0)
